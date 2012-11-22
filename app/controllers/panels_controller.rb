class PanelsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  caches_action :show
  
  # GET /panels/1.css
  def show
    panel = Panel.find_by_name(params[:id])
    if panel
      @favicons = panel.favicons

      if panel.complete
        expires_in 1.year, public: true
      else
        expires_now
      end
      
      respond_to do |format|
        format.css
      end
    else
      not_found
    end
  end

  # POST /panels.json
  def create
    name = generate_name(params[:hostnames])
    @panel = Panel.where(name: name).first
        
    if @panel.nil?
      @panel = Panel.create(name: name)
      favicon_ids = []
      
      params[:hostnames].each do |hostname|
        favicon = Favicon.where(hostname: hostname).first_or_create
        favicon.favicon_panels.create(panel_id: @panel.id)
        unless favicon.favicon
          favicon_ids << favicon.id
        end
      end
      
      if favicon_ids.any?
        favicon_count = favicon_ids.length
        favicon_ids.each { |favicon_id| FaviconCreator.perform_async(favicon_id) }
      end
      
      PanelCompleter.delay_for(1.minute).perform(@panel.id)
      
      status = :created
    else
      status = :found
    end
    
    respond_to do |format|
      if @panel
        format.json { render json: {name: @panel.name}, status: status }
      else
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def status
    @panel = Panel.find_by_name(params[:id])
    respond_to do |format|
      if @panel
        format.json { render json: {complete: @panel.complete, exists: true}, status: :ok }
      elsif @panel.nil?
        format.json { render json: {complete: false, exists: false}, status: :ok }
      else
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end
  
end

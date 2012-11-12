class PanelsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  caches_action :show
  
  # GET /panels/1
  # GET /panels/1.json
  def show
    panel = Panel.find_by_name(params[:id])
    
    if panel
      @favicons = panel.favicons
      # Set longer cache headers if the panel is built. Otherwise we want to
      # expire it immediately so the panel will be requested next time
      if panel.complete
        expires_in 1.month, :public => true
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

  # POST /panels
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
        Resque.enqueue(FaviconCreator, favicon_ids, @panel.name)
      end
      
      status = :created
    else
      status = :found
    end
    
    respond_to do |format|
      if @panel
        format.json { 
          render json: {name: @panel.name}, 
          status: status, 
          location: panel_url(@panel, format: :css)
        }
      else
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
end

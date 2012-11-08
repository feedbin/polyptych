class PanelsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  caches_action :show
  
  # GET /panels/1
  # GET /panels/1.json
  def show
    panel = Panel.find_by_name(params[:id]) || not_found
    @favicons = panel.favicons

    respond_to do |format|
      format.css
    end
  end

  # POST /panels
  # POST /panels.json
  def create
    name = generate_name(params[:hostnames])
    
    @panel = Panel.where(name: name).first
        
    if @panel.nil?
      @panel = Panel.create(name: name)
      params[:hostnames].each do |hostname|
        favicon = Favicon.where(hostname: hostname).first_or_create
        favicon.favicon_panels.create(panel_id: @panel.id)
        unless favicon.favicon
          Resque.enqueue(FaviconCreator, favicon.id)
        end
      end
    end

    respond_to do |format|
      if @panel
        format.json { render json: {name: @panel.name}, status: :created, location: panel_url(@panel, format: :css) }
      else
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
end

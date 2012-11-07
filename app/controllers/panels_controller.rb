class PanelsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  # GET /panels/1
  # GET /panels/1.json
  def show
    @favicons = Panel.first.favicons
    respond_to do |format|
      format.css
    end
  end

  # POST /panels
  # POST /panels.json
  def create
    begin
      ActiveRecord::Base.transaction do
        @panel = Panel.create(name: generate_name(params[:hostnames]))
        params[:hostnames].each do |hostname|
          favicon = Favicon.where(hostname: hostname).first_or_create
          favicon.favicon_panels.create(panel_id: @panel.id)
        end
      end
      @panel.generate_name
    rescue Exception => e
      
    end
    
    
    logger.info panels_url(@panel)

    respond_to do |format|
      if @panel.save
        format.json { render json: {name: @panel.name}, status: :created, location: panel_url(@panel, format: :css) }
      else
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
end

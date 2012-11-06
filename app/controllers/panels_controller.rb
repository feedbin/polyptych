class PanelsController < ApplicationController

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
    @panel = Panel.new(params[:panel])

    respond_to do |format|
      if @panel.save
        format.html { redirect_to @panel, notice: 'Panel was successfully created.' }
        format.json { render json: @panel, status: :created, location: @panel }
      else
        format.html { render action: "new" }
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end
  
end

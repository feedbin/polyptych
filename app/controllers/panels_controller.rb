class PanelsController < ApplicationController
  # GET /panels
  # GET /panels.json
  def index
    @panels = Panel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @panels }
    end
  end

  # GET /panels/1
  # GET /panels/1.json
  def show
    @panel = Panel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @panel }
    end
  end

  # GET /panels/new
  # GET /panels/new.json
  def new
    @panel = Panel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @panel }
    end
  end

  # GET /panels/1/edit
  def edit
    @panel = Panel.find(params[:id])
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

  # PUT /panels/1
  # PUT /panels/1.json
  def update
    @panel = Panel.find(params[:id])

    respond_to do |format|
      if @panel.update_attributes(params[:panel])
        format.html { redirect_to @panel, notice: 'Panel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /panels/1
  # DELETE /panels/1.json
  def destroy
    @panel = Panel.find(params[:id])
    @panel.destroy

    respond_to do |format|
      format.html { redirect_to panels_url }
      format.json { head :no_content }
    end
  end
end

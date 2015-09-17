class TextdescsController < ApplicationController
  # GET /textdescs
  # GET /textdescs.json
  def index
    @textdescs = Textdesc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @textdescs }
    end
  end

  # GET /textdescs/1
  # GET /textdescs/1.json
  def show
    @textdesc = Textdesc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @textdesc }
    end
  end

  # GET /textdescs/new
  # GET /textdescs/new.json
  def new
    @textdesc = Textdesc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @textdesc }
    end
  end

  # GET /textdescs/1/edit
  def edit
    @textdesc = Textdesc.find(params[:id])
  end

  # POST /textdescs
  # POST /textdescs.json
  def create
    @textdesc = Textdesc.new(params[:textdesc])

    respond_to do |format|
      if @textdesc.save
        format.html { redirect_to @textdesc, notice: 'Textdesc was successfully created.' }
        format.json { render json: @textdesc, status: :created, location: @textdesc }
      else
        format.html { render action: "new" }
        format.json { render json: @textdesc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /textdescs/1
  # PUT /textdescs/1.json
  def update
    @textdesc = Textdesc.find(params[:id])

    respond_to do |format|
      if @textdesc.update_attributes(params[:textdesc])
        format.html { redirect_to @textdesc, notice: 'Textdesc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @textdesc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /textdescs/1
  # DELETE /textdescs/1.json
  def destroy
    @textdesc = Textdesc.find(params[:id])
    @textdesc.destroy

    respond_to do |format|
      format.html { redirect_to textdescs_url }
      format.json { head :no_content }
    end
  end
end

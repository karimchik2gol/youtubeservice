class YslygisController < ApplicationController
  # GET /yslygis
  # GET /yslygis.json
  def index
    @yslygis = Yslygi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @yslygis }
    end
  end

  # GET /yslygis/1
  # GET /yslygis/1.json
  def show
    @yslygi = Yslygi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @yslygi }
    end
  end

  # GET /yslygis/new
  # GET /yslygis/new.json
  def new
    @yslygi = Yslygi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @yslygi }
    end
  end

  # GET /yslygis/1/edit
  def edit
    @yslygi = Yslygi.find(params[:id])
  end

  # POST /yslygis
  # POST /yslygis.json
  def create
    @yslygi = Yslygi.new(params[:yslygi])

    respond_to do |format|
      if @yslygi.save
        format.html { redirect_to @yslygi, notice: 'Yslygi was successfully created.' }
        format.json { render json: @yslygi, status: :created, location: @yslygi }
      else
        format.html { render action: "new" }
        format.json { render json: @yslygi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /yslygis/1
  # PUT /yslygis/1.json
  def update
    @yslygi = Yslygi.find(params[:id])

    respond_to do |format|
      if @yslygi.update_attributes(params[:yslygi])
        format.html { redirect_to @yslygi, notice: 'Yslygi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @yslygi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yslygis/1
  # DELETE /yslygis/1.json
  def destroy
    @yslygi = Yslygi.find(params[:id])
    @yslygi.destroy

    respond_to do |format|
      format.html { redirect_to yslygis_url }
      format.json { head :no_content }
    end
  end
end

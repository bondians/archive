class GenresController < ApplicationController
  # GET /genres
  # GET /genres.xml
  def index
    if params[:q]
      @genres = Genre.all :conditions => ["name like ?", params[:q] + '%']
    else
      #@genres = Genre.find(:all)
      @genres = Genre.search params[:search], :order => :name, :page => params[:page], :per_page => 100
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /genres/1
  # GET /genres/1.xml
  def show
    @genre = Genre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @genre }
    end
  end

  # GET /genres/new
  # GET /genres/new.xml
  def new
    @genre = Genre.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @genre }
    end
  end

  # GET /genres/1/edit
  def edit
    @genre = Genre.find(params[:id])
  end

  # POST /genres
  # POST /genres.xml
  def create
    @genre = Genre.new(params[:genre])

    respond_to do |format|
      if @genre.save
        flash[:note] = 'Genre was successfully created.'
        format.html { redirect_to(@genre) }
        format.xml  { render :xml => @genre, :status => :created, :location => @genre }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @genre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /genres/1
  # PUT /genres/1.xml
  def update
    @genre = Genre.find(params[:id])

    respond_to do |format|
      if @genre.update_attributes(params[:genre])
        flash[:note] = 'Genre was successfully updated.'
        format.html { redirect_to(@genre) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @genre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /genres/1
  # DELETE /genres/1.xml
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy

    respond_to do |format|
      format.html { redirect_to(genres_url) }
      format.xml  { head :ok }
    end
  end
end

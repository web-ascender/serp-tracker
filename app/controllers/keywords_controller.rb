class KeywordsController < ApplicationController
  before_filter :set_client
  before_filter :set_website

  def index
    @keywords = @website.keywords    
  end

  def new
    @keyword = @website.keywords.new    
  end

  def create
    @keyword = @website.keywords.new(params[:keyword])
    if @keyword.save
      redirect_to client_website_keywords_path(@client,@website), notice: 'Keyword was successfully created.'
    else
      render :new
    end
  end

  def edit
    @keyword = @website.keywords.find(params[:id])    
  end

  def update
    @keyword = @website.keywords.find(params[:id])

    if @keyword.update_attributes(params[:keyword])
      redirect_to client_website_keywords_path(@client,@website), notice: 'Keyword was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @keyword = @website.keywords.find(params[:id])
    @keyword.destroy
    redirect_to client_website_keywords_path(@client,@website), notice: "Keyword removed"
  end


end

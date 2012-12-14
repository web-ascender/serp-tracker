class WebsitesController < ApplicationController
  before_filter :set_client

  def index
    @websites = current_user.clients.find(@client).websites
  end

  def new
    @website = current_user.clients.find(@client).websites.new
  end

  def create
    @website = current_user.clients.find(@client).websites.new(params[:website])
    if @website.save
      redirect_to client_websites_path(@client), notice: 'Website was successfully created.'
    else
      render :new
    end
  end

  def edit
    @website = current_user.clients.find(@client).websites.find(params[:id])    
  end

  def update
    @website = current_user.clients.find(@client).websites.find(params[:id])

    if @website.update_attributes(params[:website])
      redirect_to client_websites_path(@client), notice: 'Website was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @website = current_user.clients.find(@client).websites.find(params[:id])
    @website.destroy
    redirect_to client_websites_path(@client), notice: "Client removed"
  end

  def set_client
    @client = current_user.clients.find(params[:client_id])
  end
end

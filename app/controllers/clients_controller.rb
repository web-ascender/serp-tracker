class ClientsController < ApplicationController
  def index
    @clients = current_user.clients
  end

  def new
    @client = current_user.clients.new
  end

  def create
    @client = current_user.clients.new(params[:client])
    if @client.save
      redirect_to :clients, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def edit
    @client = current_user.clients.find(params[:id])
  end

  def update
    @client = current_user.clients.find(params[:id])

    if @client.update_attributes(params[:client])
      redirect_to :clients, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client = current_user.clients.find(params[:id])
    @client.destroy
    redirect_to :clients, notice: "Client removed"
  end
end

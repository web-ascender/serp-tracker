class ApplicationController < ActionController::Base
  protect_from_forgery


  def set_client
    @client = current_user.clients.find(params[:client_id])
  end
  def set_website
    @website = @client.websites.find(params[:website_id])
  end
  def set_keyword
    @keyword = @website.keywords.find(params[:keyword_id])
  end

end

class SourceReportsController < ApplicationController
  before_filter :set_client
  before_filter :set_website

  def index
    @reports = @website.source_reports
  end

  def new
    @website.source_reports.create
    redirect_to client_website_source_reports_path(@client,@website), :notice => "Created"
  end

  def show
    @report = @website.source_reports.find(params[:id])    
  end
end

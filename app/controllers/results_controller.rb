class ResultsController < ApplicationController
  def index
    @results = Result.all
  end

  def detail
    @result = Result.find(params["id"])
  end

  def pdf
    @result = Result.find(params["id"])
    render :pdf => "pdf"
  end
end

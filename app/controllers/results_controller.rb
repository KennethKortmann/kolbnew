class ResultsController < ApplicationController
  def index
    @results = Result.all
  end

  def detail
    @result = Result.find(params["id"])
  end
end

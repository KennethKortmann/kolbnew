class ResultsController < ApplicationController
  def index
    @results = Result.all
  end

  def detail
    @result = Result.find(params["id"])
    @veryStrongPref = @result[:very_strong_pref].split(',')
    @strongPref = @result[:strong_pref].split(',')
    @moderatePref = @result[:moderat_pref].split(',')
    @lowPref = @result[:low_pref].split(',')
    @veryLowPref = @result[:very_low_pref].split(',')
  end

  def pdf
    @result = Result.find(params["id"])
    @veryStrongPref = @result[:very_strong_pref].split(',')
    @strongPref = @result[:strong_pref].split(',')
    @moderatePref = @result[:moderat_pref].split(',')
    @lowPref = @result[:low_pref].split(',')
    @veryLowPref = @result[:very_low_pref].split(',')
    render :pdf => "Working style results"
  end
end

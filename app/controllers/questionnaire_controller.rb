class QuestionnaireController < ApplicationController
  def index
    @questions = Questionnaire.select("question", "id")
  end

  def pdf
    render :pdf => "pdf"
  end
end

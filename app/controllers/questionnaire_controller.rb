class QuestionnaireController < ApplicationController
  def index
    @questions = Questionnaire.select("question", "id")
  end
end

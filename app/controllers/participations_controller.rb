class ParticipationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def participate
    participant = params["participant"]
    getWorkingStyles()
    parseAnswers()

    Result.new(:name => participant, :very_low_pref => getVeryLowPreferenceWorkingStyles().to_s, :low_pref => getLowPreferenceWorkingStyles().to_s, :moderat_pref => getModeratePreferenceWorkingStyles().to_s, :strong_pref => getStrongPreferenceWorkingStyles().to_s, :very_strong_pref => getVeryStrongPreferenceWorkingStyles().to_s).save
    redirect_to :controller => 'results', :action => 'index'
  end

  def getVeryStrongPreferenceWorkingStyles
    @veryStrongWorkingStyles = []
    if @activistPoints >= 13
      @veryStrongWorkingStyles << "Activist"
    end
    if @reflectorPoints >= 18
      @veryStrongWorkingStyles << "Reflector"
    end
    if @theoristPoints >= 16
      @veryStrongWorkingStyles << "Theorist"
    end
    if @pragmatistPoints >= 17
      @veryStrongWorkingStyles << "Pragmatist"
    end
  end

  def getStrongPreferenceWorkingStyles
    @strongWorkingStyles = []
    if @activistPoints >= 11 && @activistPoints <= 12
      @strongWorkingStyles << "Activist"
    end
    if @reflectorPoints >= 15 && @reflectorPoints <= 17
      @strongWorkingStyles << "Reflector"
    end
    if @theoristPoints >= 14 && @theoristPoints <= 15
      @strongWorkingStyles << "Theorist"
    end
    if @pragmatistPoints >= 15 && @pragmatistPoints <= 15
      @strongWorkingStyles << "Pragmatist"
    end
  end

  def getModeratePreferenceWorkingStyles
    @moderateWorkingStyles = []
    if @activistPoints >= 7 && @activistPoints <= 10
      @moderateWorkingStyles << "Activist"
    end
    if @reflectorPoints >= 12 && @reflectorPoints <= 14
      @moderateWorkingStyles << "Reflector"
    end
    if @theoristPoints >= 11 && @theoristPoints <= 13
      @moderateWorkingStyles << "Theorist"
    end
    if @pragmatistPoints >= 12 && @pragmatistPoints <= 14
      @moderateWorkingStyles << "Pragmatist"
    end
  end

  def getLowPreferenceWorkingStyles
    @lowWorkingStyles = []
    if @activistPoints >= 4 && @activistPoints <= 6
      @lowWorkingStyles << "Activist"
    end
    if @reflectorPoints >= 9 && @reflectorPoints <= 11
      @lowWorkingStyles << "Reflector"
    end
    if @theoristPoints >= 8 && @theoristPoints <= 10
      @lowWorkingStyles << "Theorist"
    end
    if @pragmatistPoints >= 9 && @pragmatistPoints <= 11
      @lowWorkingStyles << "Pragmatist"
    end
  end

  def getVeryLowPreferenceWorkingStyles
    @veryLowWorkingStyles = []
    if @activistPoints <= 3
      @veryLowWorkingStyles << "Activist"
    end
    if @reflectorPoints <= 8
      @veryLowWorkingStyles << "Reflector"
    end
    if @theoristPoints <= 7
      @veryLowWorkingStyles << "Theorist"
    end
    if @pragmatistPoints <= 8
      @veryLowWorkingStyles << "Pragmatist"
    end
  end

  def getWorkingStyles
    @activistPossibleAnswers = []
    @reflectorPossibleAnswers = []
    @theoristPossibleAnswers = []
    @pragmatistPossibleAnswers = []
    questions = Questionnaire.all
    questions.each do |question|
      if question[:workingstyle] == "Activist"
        @activistPossibleAnswers << question[:id]
      elsif question[:workingstyle] == "Theorist"
        @theoristPossibleAnswers << question[:id]
      elsif question[:workingstyle] == "Reflector"
        @reflectorPossibleAnswers << question[:id]
      elsif question[:workingstyle] == "Pragmatist"
        @pragmatistPossibleAnswers << question[:id]
      end
    end
  end

  def parseAnswers
    answers = []
    for i in 1..80
      if params["q_#{i}"] == "yes"
        then answers << i
      end
    end
    @activistPoints = 0
    @theoristPoints = 0
    @pragmatistPoints = 0
    @reflectorPoints = 0
    for answer in answers
      if @activistPossibleAnswers.include? answer then
        @activistPoints = @activistPoints + 1
      elsif @theoristPossibleAnswers.include? answer then
        @theoristPoints = @theoristPoints + 1
      elsif @pragmatistPossibleAnswers.include? answer then
        @pragmatistPoints = @pragmatistPoints + 1
      elsif @reflectorPossibleAnswers.include? answer then
        @reflectorPoints = @reflectorPoints + 1
      end
    end
  end
end

class ParticipationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def participate
    participant = params["participant"]
    getWorkingStyles()
    parseAnswers()

    veryLow = getVeryLowPreferenceWorkingStyles().join(',')
    low = getLowPreferenceWorkingStyles().join(',')
    moderate = getModeratePreferenceWorkingStyles().join(',')
    strong = getStrongPreferenceWorkingStyles().join(',')
    veryStrong = getVeryStrongPreferenceWorkingStyles().join(',')

    Result.new(
      :name => participant,
      :very_low_pref => veryLow,
      :low_pref => low ,
      :moderat_pref => moderate,
      :strong_pref => strong,
      :very_strong_pref => veryStrong
    ).save
    redirect_to :controller => 'results', :action => 'index'
  end

  def getVeryStrongPreferenceWorkingStyles
    @veryStrongWorkingStyles = []
    if @activistPoints >= 13
      @veryStrongWorkingStyles.push "Activist"
    end
    if @reflectorPoints >= 18
      @veryStrongWorkingStyles.push "Reflector"
    end
    if @theoristPoints >= 16
      @veryStrongWorkingStyles.push "Theorist"
    end
    if @pragmatistPoints >= 17
      @veryStrongWorkingStyles.push "Pragmatist"
    end
    return @veryStrongWorkingStyles
  end

  def getStrongPreferenceWorkingStyles
    @strongWorkingStyles = []
    if @activistPoints >= 11 && @activistPoints <= 12
      @strongWorkingStyles.push "Activist"
    end
    if @reflectorPoints >= 15 && @reflectorPoints <= 17
      @strongWorkingStyles.push "Reflector"
    end
    if @theoristPoints >= 14 && @theoristPoints <= 15
      @strongWorkingStyles.push "Theorist"
    end
    if @pragmatistPoints >= 15 && @pragmatistPoints <= 15
      @strongWorkingStyles.push "Pragmatist"
    end
    return @strongWorkingStyles
  end

  def getModeratePreferenceWorkingStyles
    @moderateWorkingStyles = []
    if @activistPoints >= 7 && @activistPoints <= 10
      @moderateWorkingStyles.push "Activist"
    end
    if @reflectorPoints >= 12 && @reflectorPoints <= 14
      @moderateWorkingStyles.push "Reflector"
    end
    if @theoristPoints >= 11 && @theoristPoints <= 13
      @moderateWorkingStyles.push "Theorist"
    end
    if @pragmatistPoints >= 12 && @pragmatistPoints <= 14
      @moderateWorkingStyles.push "Pragmatist"
    end
    return @moderateWorkingStyles
  end

  def getLowPreferenceWorkingStyles
  puts @activistPoints
  puts @reflectorPoints
  puts @theoristPoints
  puts @pragmatistPoints
    @lowWorkingStyles = []
    if @activistPoints >= 4 && @activistPoints <= 6
      @lowWorkingStyles.push "Activist"
    end
    if @reflectorPoints >= 9 && @reflectorPoints <= 11
      @lowWorkingStyles.push "Reflector"
    end
    if @theoristPoints >= 8 && @theoristPoints <= 10
      @lowWorkingStyles.push "Theorist"
    end
    if @pragmatistPoints >= 9 && @pragmatistPoints <= 11
      @lowWorkingStyles.push "Pragmatist"
    end
    return @lowWorkingStyles
  end

  def getVeryLowPreferenceWorkingStyles
    @veryLowWorkingStyles = []
    if @activistPoints <= 3
      @veryLowWorkingStyles.push "Activist"
    end
    if @reflectorPoints <= 8
      @veryLowWorkingStyles.push "Reflector"
    end
    if @theoristPoints <= 7
      @veryLowWorkingStyles.push "Theorist"
    end
    if @pragmatistPoints <= 8
      @veryLowWorkingStyles.push "Pragmatist"
    end
    return @veryLowWorkingStyles
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

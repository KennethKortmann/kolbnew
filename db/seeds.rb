# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Questionnaire.create([
#  {question: 'activistquestion', workingstyle: 'Activist'},
#  {question: 'theoristquestion', workingstyle: 'Theorist'},
#  {question: 'pragmatistquestion', workingstyle: 'Pragmatist'},
#  {question: 'reflectorquestion', workingstyle: 'Reflector'},
#])
questionsConfig = YAML.load_file('config/kolb-questions.yml')

questionsConfig["questions"].each do |question|
  Questionnaire.create({question: question["question"], workingstyle: question["workingstyle"]});
end

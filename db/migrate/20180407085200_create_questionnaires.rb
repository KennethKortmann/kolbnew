class CreateQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    create_table :questionnaires do |t|
      t.text :question
      t.text :workingstyle

      t.timestamps
    end
  end
end

class CreateQuestionaryChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :questionary_choices do |t|
      t.text :content
      t.integer :questionary_item_id
      t.boolean :input_field, default: false

      t.timestamps
    end
  end
end

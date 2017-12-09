class CreateQuestionaryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :questionary_items do |t|
      t.text :content
      t.integer :questionary_id
      t.boolean :multiple, default: false

      t.timestamps
    end
  end
end

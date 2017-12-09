class QuestionaryChoice < ApplicationRecord
  belongs_to :questionary_item

  validates :content, presence: {message:"は必須項目です。"}
end

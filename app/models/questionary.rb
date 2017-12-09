class Questionary < ApplicationRecord
  has_many :questionary_item

  validates :title, :description, :deadline, presence: {message:"は、必須項目です。"}
end

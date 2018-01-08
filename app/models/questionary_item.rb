class QuestionaryItem < ApplicationRecord
  belongs_to :questionary
  has_many :questionary_choice
  has_many :questionary_result

  validates :content, presence: {message:"は必須項目です。"}

  def aggregate
    results = {}
    self.questionary_choice.each do |choice|
      results[choice.id] = 0 unless choice.input_field
    end
    self.questionary_result&.pluck(:result).flatten.compact.each do |result|
      results[result.to_i] = results[result.to_i] + 1
    end
    results
  end
end

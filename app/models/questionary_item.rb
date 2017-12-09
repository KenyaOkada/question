class QuestionaryItem < ApplicationRecord
  belongs_to :questionary
  has_many :questionary_choice
  has_many :questionary_result

  validates :content, presence: {message:"は必須項目です。"}

  def aggregate
    results = {}
    self.questionary_choice.pluck(:id).each do |i|
      results[i] = 0
    end
    self.questionary_result.pluck(:result).each do |result|
      if self.multiple?
        multiple_results = JSON.parse result
        multiple_results.each do |multiple_result|
          results[multiple_result.to_i] = results[multiple_result.to_i] + 1
        end
      else
        results[result.to_i] = results[result.to_i] + 1
      end
    end
    results
  end
end

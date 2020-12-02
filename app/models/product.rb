class Product < ApplicationRecord
  has_many :items
  has_many :favorites, dependent: :destroy

  after_validation :score_review

  private

  def score_review
    review = Hash.new(0)
    review.merge!({
      "a" => 1,
      "b" => 0.7,
      "c" => 0.5,
      "d" => 0.5,
      "e" => 0.5
    })
    self.score = self.score || 0

    self.score = self.score * review[self.nutriscore_grade] * review[self.ecoscore_grade]

    if self.score > 100
      self.score = 100
    end

    if self.score < 0
      self.score = 0
    end
  end
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments


  validates_length_of :url, minimum: 5
  validates_length_of :title, minimum: 5

  def points
    self.votes.sum(&:value)
  end
end
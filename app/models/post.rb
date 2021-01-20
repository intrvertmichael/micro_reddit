class Post < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments


  validates_length_of :title, minimum: 5
  validates_length_of :url, minimum: 5

  validates_format_of :url, :with => /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix

  def points
    self.votes.sum(&:value)
  end
end
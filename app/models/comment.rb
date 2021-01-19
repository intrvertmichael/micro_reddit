class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user

    has_many :comment, :class_name => 'Comment', :foreign_key => 'parent_id'

    has_many :comment_votes

    validates_length_of :body, minimum: 5

    def points
        self.comment_votes.sum(&:value)
    end

end
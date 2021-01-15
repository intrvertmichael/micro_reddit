class User < ApplicationRecord

    has_secure_password
    validates_presence_of :username
    validates_uniqueness_of :username

    has_many :posts
    has_many :votes
    has_many :comments
    has_many :comment_votes


    def post_amount
        self.posts.count
    end

    def comment_amount
        self.comments.count
    end
end

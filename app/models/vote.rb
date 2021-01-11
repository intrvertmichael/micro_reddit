class Vote < ApplicationRecord
    belongs_to :post
    has_one :user
end

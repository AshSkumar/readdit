class Comment < ApplicationRecord
	validates :body, presence: true
	belongs_to :user, dependent: :destroy
    belongs_to :commentable, polymorphic: true, dependent: :destroy
    has_many :comments, as: :commentable
end

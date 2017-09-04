class Story < ApplicationRecord
	belongs_to :user, dependent: :destroy
	has_many :comments, as: :commentable
	validates :title, :url, presence: true

	after_validation :smart_add_url_protocol

	has_many :likes, dependent: :destroy
    has_many :dislikes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :users
    has_many :disliked_users, through: :dislikes, source: :users

    protected

    def smart_add_url_protocol
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
        self.url = "http://#{self.url}"
      end
    end
end

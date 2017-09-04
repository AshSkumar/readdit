class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, length: { minimum: 2, maximum: 20}, uniqueness: true

  has_many :stories
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :liked_stories, through: :likes, source: :stories
  has_many :disliked_stories, through: :dislikes, source: :stories

  has_many :likes_received, through: :stories, source: :likes
  has_many :dislikes_received, through: :stories, source: :dislikes

  has_attached_file :avatar, :default_url => '/assets/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  # returns 1 for like -1 for dislike and 0 for neither if a post is hearted by user
  def liked?(story)
    if self.likes.find_by_story_id(story.id)
      return 1
    elsif self.dislikes.find_by_story_id(story.id)
      return -1
    else 
      return 0
    end
  end

end


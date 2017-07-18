class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100" },
  default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", :foreign_key => "friend_id"

  has_many :friends, -> { where(friendships: { accepted: true }) }, :through => :friendships
  has_many :inverse_friends, -> { where(friendships: { accepted: true }) }, :through => :inverse_friendships, :source => :user

  has_many :pending_requests, -> { where(friendships: { accepted: false }) }, :through => :friendships, source: :friend
  has_many :sent_requests, -> { where(friendships: { accepted: false }) }, :through => :inverse_friendships, :source => :user

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def feed
    Post.where("user_id in (?) OR user_id in (?) OR user_id = ?", friend_ids, inverse_friend_ids, id)
  end

  def friend?
    User.where("id in (?) OR id in (?) OR id in (?) OR id in (?) OR id = ?", friend_ids, inverse_friend_ids, pending_request_ids, sent_request_ids, id)
  end

end

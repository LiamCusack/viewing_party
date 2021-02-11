class User < ApplicationRecord
  attr_accessor :password_confirmation
  has_secure_password

  has_many :parties

  validates :email, uniqueness: true, presence:true
  validates :password, presence: true

  has_many :senders, foreign_key: :sender_id, class_name: "Friend"
  has_many :receivers, through: :senders

  has_many :receivers, foreign_key: :receiver_id, class_name: "Friend"
  has_many :senders, through: :receivers

  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  validates :password_confirmation, presence: true
  validates_confirmation_of :password

  def get_parties
    {
      hosting: Party.where(user_id: id),
      invited: parties
    }
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
          :rememberable, :trackable, :validatable, :omniauthable, 
          omniauth_providers: [:facebook]

  has_many :lists_users
  has_many :lists, through: :lists_users
  has_many :chores, through: :lists
  has_many :invites

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.imgurl = auth.info.image + "?type=large"
      user.password = Devise.friendly_token[0,20]
      if Invite.find_by(email: user.email)
        invite = Invite.find_by(email: user.email)
        user.invites << invite
      end
    end
  end


end
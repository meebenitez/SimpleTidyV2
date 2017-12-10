class List < ApplicationRecord
  has_many :lists_users
  has_many :users, through: :lists_users
  has_many :chores
  has_many :invites

  accepts_nested_attributes_for :invites, reject_if: proc { |attributes| attributes['email'].blank? }

  validates :name, presence: true
  
  #def admin_name=(id)
   # admin = User.find(id: id)
   # self.admin = admin
  #end

end

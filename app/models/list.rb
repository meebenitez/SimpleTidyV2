class List < ApplicationRecord
  has_many :lists_users
  has_many :users, through: :lists_users
  has_many :chores
  has_many :invites


  #def admin_name=(id)
   # admin = User.find(id: id)
   # self.admin = admin
  #end

end

class ListsUser < ApplicationRecord
  belongs_to :user
  belongs_to :list

  scope :jointables, -> (id) { where("list_id = ?", id) }


  def self.set_admin(list, user)
    self.find_by(list_id: list.id, user_id: user.id).update(admin: user.id)
  end


end


class ListsUser < ApplicationRecord
  belongs_to :user
  belongs_to :list

  scope :jointables, -> (id) { where("list_id = ?", id) }
end

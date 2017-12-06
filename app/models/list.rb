class List < ApplicationRecord
  has_many :lists_users
  has_many :users, through: :lists_users
  has_many :chores
end

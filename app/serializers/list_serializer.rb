class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :list_type
  has_many :chores
end

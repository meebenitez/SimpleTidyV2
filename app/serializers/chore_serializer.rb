class ChoreSerializer < ActiveModel::Serializer
  attributes :name, :frequency, :time_of_day, :status, :past_due
  belongs_to :list
end

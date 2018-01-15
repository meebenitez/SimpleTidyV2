class TipSerializer < ActiveModel::Serializer
  attributes :id, :title, :tip, :source_name, :source_url
end

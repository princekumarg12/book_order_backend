class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :relative_type, :relative_name, :mobile, :gender
end

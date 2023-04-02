class SignupSerializer < ActiveModel::Serializer
  attributes :id, :name, :difficulty

  belongs_to :camper
  belongs_to :activity

  # attributes :id, :time
  # has_one :camper
  # has_one :activity
end

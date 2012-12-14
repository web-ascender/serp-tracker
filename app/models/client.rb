class Client < ActiveRecord::Base
  belongs_to :user
  has_many :websites
  attr_protected :id
end

# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string(255)
#  description   :string(255)
#  contact_name  :string(255)
#  contact_email :string(255)
#  contact_phone :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Client < ActiveRecord::Base
  belongs_to :user
  has_many :websites
  attr_protected :id
end

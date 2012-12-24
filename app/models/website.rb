# == Schema Information
#
# Table name: websites
#
#  id            :integer          not null, primary key
#  client_id     :integer
#  name          :string(255)
#  url           :string(255)
#  search_google :boolean          default(TRUE)
#  search_bing   :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Website < ActiveRecord::Base
  belongs_to :client
  has_many :keywords
  
  attr_protected :id

  # attr_accessible :title, :body
end

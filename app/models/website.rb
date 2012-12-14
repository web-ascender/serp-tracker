class Website < ActiveRecord::Base
  belongs_to :client
  has_many :keywords
  
  attr_protected :id

  # attr_accessible :title, :body
end

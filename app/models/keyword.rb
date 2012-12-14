class Keyword < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id
  belongs_to :website
end

# == Schema Information
#
# Table name: keywords
#
#  id             :integer          not null, primary key
#  website_id     :integer
#  keyword_phrase :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  position       :integer
#

class Keyword < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id
  belongs_to :website
  has_many :keyword_results
end

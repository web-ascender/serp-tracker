# == Schema Information
#
# Table name: keyword_results
#
#  id            :integer          not null, primary key
#  keyword_id    :integer
#  search_engine :string(255)
#  position      :integer
#  html          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class KeywordResult < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :keyword
  attr_protected :id

end

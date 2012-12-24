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

require 'test_helper'

class KeywordResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

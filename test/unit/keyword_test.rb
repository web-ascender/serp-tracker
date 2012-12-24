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

require 'test_helper'

class KeywordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

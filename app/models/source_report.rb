class SourceReport < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_protected :id
  belongs_to :website
  has_many :pages
  after_create :create_first_page

  def create_first_page
    self.pages.create(:url => self.website.url)
  end
end

class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :text
  validates :text, :presence => true
end

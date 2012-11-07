class Post < ActiveRecord::Base
  attr_accessible :text, :title
  has_many :comments
  validates :title, :presence=>true, :uniqueness => true
end

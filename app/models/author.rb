class Author < ActiveRecord::Base
  has_many :products
  has_many :custom_orders

  validates :name, :presence => true
  validates :name, :uniqueness => true

end

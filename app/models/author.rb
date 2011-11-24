class Author < ActiveRecord::Base
  has_many :products , :dependent => :delete_all
  has_many :custom_orders
  has_one :user

  validates :name, :presence => true
  validates :name, :uniqueness => true

end

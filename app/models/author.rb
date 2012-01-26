# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_many :products , :dependent => :delete_all
  has_one :user

  validates :name, :presence => true
  validates :name, :uniqueness => true

end

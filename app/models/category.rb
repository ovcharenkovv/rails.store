class Category < ActiveRecord::Base
  has_many :products

  validates :name, :presence => true
  validates :name, :uniqueness => true

  acts_as_tree :order => "name"

  scope :root_category, :conditions => { :parent_id => nil  } , :order => "ordering"
  #scope :in_category, lambda {|c| {:include => [:category], :conditions => ["categories.id = ? OR categories.parent_id = ?", c, c]} }

end

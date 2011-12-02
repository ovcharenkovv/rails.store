class Category < ActiveRecord::Base
  has_many :products

  validates :name, :presence => true
  validates :name, :uniqueness => true

  acts_as_tree :order => "name"

  scope :root_category, :conditions => { :parent_id => nil  } , :order => "ordering"
  scope :non_root_category, :conditions => "parent_id IS NOT NULL", :order => "ordering"
  #scope :in_category, lambda {|c| {:include => [:category], :conditions => ["categories.id = ? OR categories.parent_id = ?", c, c]} }

  def all_children
    all = []
    self.children.each do |category|
      all << category
      root_children = category.all_children.flatten
      all << root_children unless root_children.empty?
    end
    return all.flatten
  end

  def self.without_children
    all = []
    find(:all,:order=>"ordering").each do |category|
      if category.children.count <=1
        all << category
      end
    end
    all
  end


end

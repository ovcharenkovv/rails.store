class CustomOrder < ActiveRecord::Base

  belongs_to :author
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "170x170>" }

  validates :name,     :presence => true,
                       :length => {:minimum => 3, :maximum => 254}

  validates :email,    :presence => true,
                       :length => {:minimum => 3, :maximum => 254},
                       :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  validates :description,  :phone, :presence => true

end

# -*- encoding : utf-8 -*-
class Address < ActiveRecord::Base
  
  belongs_to :addressable, :polymorphic => true
  belongs_to :country
end

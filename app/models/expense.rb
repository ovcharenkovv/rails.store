class Expense < ActiveRecord::Base
  def self.for_month month
    find(:all, :conditions => [" MONTH(created_at) = ?", month])
  end
end

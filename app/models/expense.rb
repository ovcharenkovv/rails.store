class Expense < ActiveRecord::Base
  def self.for_month month
    find(:all, :conditions => [" MONTH(created_at) between ? AND ?", month-1, month])
  end
end

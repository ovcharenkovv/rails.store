class Upload < ActiveRecord::Base
  belongs_to :product
  has_attached_file :photo,
                    :styles => {
                        :thumb => {
                            :geometry => "90x70>",
                            :quality => "50"
                        }
                    }


end

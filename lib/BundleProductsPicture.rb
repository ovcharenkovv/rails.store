# -*- encoding : utf-8 -*-
module BundleProductsPicture
  require 'rubygems'
  require 'zip/zip'

  def BundleProductsPicture.do products,image_files_path
    if !products.blank?
      t = Tempfile.new("my-temp-filename-#{Time.now}")
      Zip::ZipOutputStream.open(t.path) do |z|
        products.each do |product|
          title = product.image_file_name
          title += ".jpg" unless title.end_with?(".jpg")
          z.put_next_entry(title)
          begin
            z.print IO.read(image_files_path+product.id.to_s+'/original/'+product.image_file_name)
          rescue Errno::ENOENT
            Rails.logger.info "#{product.image_file_name} is bed name, and will not download"
          end
        end
      end
      #send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => file_name
      #t.close
      t
    end
  end
end


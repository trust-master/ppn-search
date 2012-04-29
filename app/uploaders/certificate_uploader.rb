# encoding: utf-8

class CertificateUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:

  # thumb is for a small thumbnail in the form and in the discount listing
  version :thumb, :if => :image? do
    process :thumbnailify
    convert :png

  end

  # preview is for a lightbox-style popup to view the image (only if it isn't a PDF)
  version :preview, :if => :image? do
    resize_to_limit 800, 600
  end

  # Allow only images or PDFs to be uploaded
  def extension_white_list
    %w(jpg jpeg gif png tif pdf)
  end

  protected

  def image?(new_file)
    new_file.content_type.include? 'image'
  end

  def thumbnailify(width=100)
    manipulate! do |img|
      img.collapse! # drop all but page 1
      img.format('png') # save as PNG
      img.resize(width.to_s) # resize, keeping ratio, to the width given
      img
    end
  end
end

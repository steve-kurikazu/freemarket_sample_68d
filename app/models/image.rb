class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :photo, ImageUploader
end
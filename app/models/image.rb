class Image < ApplicationRecord
  mount_uploader :item_image, ImageUploader
  belongs_to :item
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many :images
  belongs_to_active_hash :prefecture

  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  
  with_options presence: true do
    validates :name,          length:{maximum: 40}
    validates :text,          length:{maximum: 1000}
    validates :condition
    validates :delivery_fee
    validates :shipping_area
    validates :delivery_time,  numericality:{greater_than: 0}
    validates :price,         numericality:{greater_than: 0}
    validates :user_id
    validates :images
  end
end
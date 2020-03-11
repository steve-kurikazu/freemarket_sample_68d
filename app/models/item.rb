class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy
  belongs_to_active_hash :prefecture
  has_many :comments
  has_many :likes
  has_many :users, through: :likes

  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images

  with_options presence: true do
    validates :name,          length:{maximum: 10}
    validates :text,          length:{maximum: 1000}
    validates :condition
    validates :delivery_fee
    validates :shipping_area
    validates :delivery_time,  numericality:{greater_than: 0}
    validates :price,         numericality:{greater_than: 0}
    validates :user_id
    validates :status
  end

  # def self.search(search)
  #   if search
  #     @item = Item.where('name LIKE(?)', "%#{search}%")
  #   else
  #     @item = Item.all
  #   end
  # end

  def self.sort(item, sort)
    case sort
    when "price_asc"
      return item.order("price ASC")
    when "price_desc"
      return item.order("price DESC")
    when "created_desc"
      return item.order("created_at DESC")
    else
      return item
    end
  end
end


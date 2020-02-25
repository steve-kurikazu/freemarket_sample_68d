class Sending < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefectures
    validates :city
    validates :address
  end

  with_options format: {with: /\A[ぁ-んァ-ン一-龥]/} do
    validates :first_name
    validates :last_name
  end

  with_options format: {with: /\A[ぁ-んー－]+\z/} do
    validates :first_namekana
    validates :last_namekana
  end

  validates :tell, format: {with: /\A[0-9]{1,12}\z/}
end

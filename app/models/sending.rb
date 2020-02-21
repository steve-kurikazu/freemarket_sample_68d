class Sending < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :prefecture
  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_namekana
    validates :last_namekana
    validates :postal_code
    validates :prefectures
    validates :city
    validates :address
  end
end

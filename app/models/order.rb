class Order < ApplicationRecord
  belongs_to :user
  belongs_to :sending
  belongs_to :item
  belongs_to :card
end

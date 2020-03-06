FactoryBot.define do
  factory :item do
    name {"美味しいサラダ"}
    text {Faker::Lorem.sentence}
    condition {'やや傷や汚れあり'}
    delivery_fee {'着払い（購入者負担)'}
    shipping_area {'北海道'}
    delivery_time {"2"}
    price {"500"}
    category_id {"1"}
    user_id {"1"}
    status {0}
  end

end
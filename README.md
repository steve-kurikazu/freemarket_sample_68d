# furima DB設計
## users table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false,unique:true|
|email|string|null:false,unique:true|
|firstname|string|null:false|
|lastname|string|null:false|
|firstname_kana|string|null:false|
|lastname_kana|string|null:false|
|birth_year|string|null:false|
|birth_month|string|null:false|
|birth_day|string|null:false|
|encrypted_password|string|null:false|
### Association
- has_one :profile
- has_many :items
- has_many :sendings, dependent: :destroy
- has_many :cards, dependent: :destroy
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :items, through: :likes
- has_many :orders


## items table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|text|text||null:false|
|condition|string|null:false|
|delivery_fee|string|null:false|
|shipping_area|string|null:false|
|delivery_time|integer|null:false|
|price|integer|null:false|
|category_id|integer|foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|status|integer|null: false|
### Association
- belongs_to :user
- belongs_to :category
- has_many :images, dependent: :destroy
- belongs_to_active_hash :prefecture
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :users, through: :likes
- has_one :order


## profiles table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|text|text| |
|image|string| |
### Association
- belongs_to :user


## cards table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|integer|null:false|
|card_id|integer|null:false|
### Association
- belongs_to :user
- has_many :orders


## comments table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|text|text|null:false|
### Association
- belongs_to :user
- belongs_to :item


## likes table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item


## images table
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|photo|string|null:false|
### Association
- belongs_to :item


## orders table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|sending_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, unique: true, foreign_key: true|
|card_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :sending
- belongs_to :item
- belongs_to :card


## sendings table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|first_name|string|null:false|
|last_name|string|null:false|
|first_namekana|string|null:false|
|last_namekana|string|null:false|
|postal_code|string|null:false|
|prefectures|string|null:false|
|city|string|null:false|
|address|string|null:false|
|bullding_name|string|null:false|
|tell|string|null:false|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture
- has_many :orders


## categories table
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :items
- has_ancestry


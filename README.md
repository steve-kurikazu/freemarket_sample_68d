# mercari DB設計
## users table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false,unique:true|
|email|string|null:false,unique:true|
|password|string|null:false|
|firstname|string|null:false|
|lastname|string|null:false|
|firstname_kana|string|null:false|
|lastname_kana|string|null:false|
|birthday|string|null:false|
|tel|string|null:false|
### Association
- has_one :profile
- has_many :sendings, dependent: :destroy
- has_many :cards, dependent: :destroy
- has_many :orders
- has_many :items
- has_many :likes, dependent: :destroy
- has_many :items, through: :likes
- has_many :comments


## items table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|text|text||null:false|
|condition|string|null:false|
|delivery_fee|string|null:false|
|shipping_area|string|null:false|
|delivery_time|date|null:false|
|price|integer|null:false|
|user_id|integer|null: false, foreign_key: true|
|profit|integer|null:false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
|status|integer|null: false|
### Association
- belongs_to :user
- belongs_to :brand
- belongs_to :category
- belongs_to :size
- has_one :order
- has_many :images, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :users, through: :likes
- has_many :comments


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
|card_number|integer|null:false|
|exp_date|integer|null:false|
|securty_code|integer|null:false|
### Association
- belongs_to :user
- has_many :orders


## comments table
|Column|Type|Options|
|message|string|null:false|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user


## likes table
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user


## images table
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|image|string|null:false|
### Association
- belongs_to :item


## brands table
|Column|Type|Options|
|------|----|-------|
|path|string|null: false|
|name|string|null: false|
### Association
- has_many :items


## orders table
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|sending_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
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
|sending_name|string|null:false|
|sending_namekana|string|null:false|
|postal code|string|null:false|
|prefectures|string|null:false|
|city|string|null:false|
|address|string|null:false|
|bullding_name|string|null:false|
|sending_tell|string|null:false|
### Association
- belongs_to :user
- has_many :orders


## sizes table
|Column|Type|Options|
|------|----|-------|
|size_text|string|null:false|
### Association
- has_many :items
- has_many :sizes_categories
- has_many :categories, through: :sizes_categories


## categories table
|Column|Type|Options|
|------|----|-------|
|path|string|null:false|
|name|string|null:false|
### Association
- has_many :items
- has_many :sizes_categories
- has_many :sizes, through: :sizes_categories
- has_ancestry


## size_categories table
|Column|Type|Options|
|------|----|-------|
|category_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :category
- belongs_to :size
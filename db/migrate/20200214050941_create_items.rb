class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :item_name                 null: false,
      t.text       :item_text                 null: false,
      t.string     :condition                 null: false,
      t.string     :delivery_fee              null: false,
      t.string     :shipping_area             null: false,
      t.date       :delivery_time             null: false,
      t.integer    :price                     null: false,
      t.references :user, foreign_key: true   null: false,
      t.integer    :profit                    null: false,
      t.string     :status                    null: false,
      t.timestamps
    end
  end
end
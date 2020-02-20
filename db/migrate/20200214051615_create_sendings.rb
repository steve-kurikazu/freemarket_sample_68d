class CreateSendings < ActiveRecord::Migration[5.2]
  def change
    create_table :sendings do |t|
      t.references           :user,      null: false, foreign_key: true
      t.string               :sending_first_name,        null:false
      t.string               :sending_last_name,         null:false
      t.string               :sending_first_namekana,    null:false
      t.string               :sending_last_namekana,     null:false
      t.string               :postal_code,               null:false
      t.string               :prefectures,               null:false
      t.string               :city,                      null:false
      t.string               :address,                   null:false
      t.string               :building_name,             null:false
      t.string               :sending_tell,              null:false
      t.timestamps
    end
  end
end

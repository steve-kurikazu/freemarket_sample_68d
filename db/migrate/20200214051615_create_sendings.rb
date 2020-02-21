class CreateSendings < ActiveRecord::Migration[5.2]
  def change
    create_table :sendings do |t|
      t.references           :user,      null: false, foreign_key: true
      t.string               :first_name,        null:false
      t.string               :last_name,         null:false
      t.string               :first_namekana,    null:false
      t.string               :last_namekana,     null:false
      t.string               :postal_code,       null:false
      t.string               :prefectures,       null:false
      t.string               :city,              null:false
      t.string               :address,           null:false
      t.string               :building_name,     null:false
      t.string               :tell,              null:false
      t.timestamps
    end
  end
end

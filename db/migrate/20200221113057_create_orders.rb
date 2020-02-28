class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user      ,null: false, foreign_key: true
      t.references :sending   ,null: false, foreign_key: true
      t.references :item      ,null: false, unique: true, foreign_key: true
      t.references :card      ,null: false, foreign_key: true
      t.timestamps
    end
  end
end

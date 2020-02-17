class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :item_name    
      t.text       :item_text     
      t.string     :condition    
      t.string     :delivery_fee  
      t.string     :shipping_area 
      t.date       :delivery_time 
      t.integer    :price         
      t.references :user, foreign_key: true
      t.integer    :profit        
      t.string     :status        
      t.timestamps
    end
  end
end
class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :number
      t.date :date
      t.integer :state
      t.integer :user_id
      t.integer :discount
      t.boolean :credit
      t.date :credit_expiration
      t.timestamps
    end
  end
end

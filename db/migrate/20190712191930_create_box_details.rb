class CreateBoxDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :box_details do |t|
      t.integer :box_id
      t.string :payment_id
      t.decimal :amount

      t.timestamps
    end
  end
end

class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.string :bank_id
      t.integer :number
      t.date :date_giro
      t.date :date_payment
      t.string :titular
      t.decimal :amount

      t.timestamps
    end
  end
end

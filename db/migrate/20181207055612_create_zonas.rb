class CreateZonas < ActiveRecord::Migration[5.2]
  def change
    create_table :zonas do |t|
      t.string :name

      t.timestamps
    end
  end
end

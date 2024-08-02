class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.references :client_product, null: false, foreign_key: true
      t.string :activation_number
      t.string :purchase_details_pin

      t.timestamps
    end
  end
end

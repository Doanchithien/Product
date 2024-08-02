class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.references :client, null: false, foreign_key: true
      t.string :card_number, index: { unique: true }
      t.boolean :status, default: true
      t.string :pin_code

      t.timestamps
    end
  end
end

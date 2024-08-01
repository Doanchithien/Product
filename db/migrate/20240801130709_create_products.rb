class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :logo_url
      t.date :released_at
      t.references :brand, null: false, foreign_key: true
      t.decimal :price
      t.string :currency

      t.timestamps
    end
  end
end

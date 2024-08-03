class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :amount, null: false
      t.string :status, default: 'inprogress'
      t.datetime :pay_time
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end

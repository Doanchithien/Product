class AddActiveToBrand < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :active, :boolean, default: true
  end
end

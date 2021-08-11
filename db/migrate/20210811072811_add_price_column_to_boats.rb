class AddPriceColumnToBoats < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :price, :float
  end
end

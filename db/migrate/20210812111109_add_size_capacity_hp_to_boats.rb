class AddSizeCapacityHpToBoats < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :size, :float
    add_column :boats, :capacity, :integer
    add_column :boats, :hp, :integer
  end
end

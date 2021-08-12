class AddCityAndZipCodeToBoats < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :city, :string
    add_column :boats, :zip_code, :integer
  end
end

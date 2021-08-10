class AddInvoiceToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :invoice, :float
  end
end

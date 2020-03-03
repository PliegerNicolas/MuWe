class AddingToEventModelCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :country, :string
  end
end

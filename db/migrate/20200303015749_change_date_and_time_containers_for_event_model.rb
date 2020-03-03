class ChangeDateAndTimeContainersForEventModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :end_date, :end_time
    change_column :events, :end_time, :time
    change_column :events, :start_date, :date
    add_column :events, :start_time, :time
  end
end

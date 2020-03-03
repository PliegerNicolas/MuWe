class ChangeDateAndTimeContainersForEventModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :end_date, :duration
    change_column :events, :duration, :time
    change_column :events, :start_date, :date
    add_column :events, :start_time, :time
  end
end

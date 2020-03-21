class SettingCommentsOnlyToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :message, :comment
    remove_column :comments, :event_id
  end
end

class AddingTimeTrackerPerControllerCallToUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_user_activity, :datetime
  end
end

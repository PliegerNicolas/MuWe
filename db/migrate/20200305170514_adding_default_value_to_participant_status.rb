class AddingDefaultValueToParticipantStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :participants, :status, 0
  end
end

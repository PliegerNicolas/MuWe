class AddInstrumentIdColumnToParticipantsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :instrument_id, :bigint
    add_index :participants, :instrument_id
    add_foreign_key :participants, :instruments
  end
end

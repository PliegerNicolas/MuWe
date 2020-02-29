class ChangingInstrumentModelTypeToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :instruments, :type, :name
  end
end

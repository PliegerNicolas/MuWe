class CreateInstrumentUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :instrument_users do |t|
      t.references :user, foreign_key: true
      t.references :instrument, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end

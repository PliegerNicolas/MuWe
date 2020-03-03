class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :music_style, foreign_key: true
      t.string :city
      t.string :address
      t.float :longitude
      t.float :latitude
      t.text :description
      t.integer :max_players
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end

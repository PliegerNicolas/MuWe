class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.references :city, foreign_key: true
      t.string :last_name
      t.date :birth_date
      t.text :bio

      t.timestamps
    end
  end
end

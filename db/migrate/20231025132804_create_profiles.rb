class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :surname, null: false
      t.string :gender, null: false
      t.date :birthday, null: false

      t.timestamps
    end
  end
end

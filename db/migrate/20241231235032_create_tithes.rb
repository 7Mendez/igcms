class CreateTithes < ActiveRecord::Migration[8.0]
  def change
    create_table :tithes do |t|
      t.decimal :amount
      t.text :note
      t.date :date
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end

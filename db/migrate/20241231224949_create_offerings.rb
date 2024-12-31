class CreateOfferings < ActiveRecord::Migration[8.0]
  def change
    create_table :offerings do |t|
      t.decimal :amount
      t.string :offering_type
      t.date :date
      t.text :note
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end

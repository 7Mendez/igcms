class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string :name
      t.boolean :status
      t.date :baptism_date
      t.boolean :holy_spirit
      t.boolean :visitor

      t.timestamps
    end
  end
end

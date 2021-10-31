class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :label
      t.integer :value

      t.timestamps
    end
  end
end

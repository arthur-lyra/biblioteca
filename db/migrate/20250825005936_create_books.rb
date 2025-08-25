class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :category
      t.integer :total_quantity, default: 0, null: false
      t.integer :available_quantity, default: 0, null: false
      t.text :synopsis

      t.timestamps
    end
    add_index :books, :title
    add_index :books, :author
    add_index :books, :category
  end
end

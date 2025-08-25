class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :borrowed_at
      t.datetime :returned_at
      t.integer :status, default: 0, null: false # 0=active, 1=returned, 2=late

      t.timestamps
    end
    add_index :loans, [:user_id, :book_id]
  end
end

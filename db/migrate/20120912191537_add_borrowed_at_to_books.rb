class AddBorrowedAtToBooks < ActiveRecord::Migration
  def change
    add_column :books, :borrowed_at, :datetime
  end
end

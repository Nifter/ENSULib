class RemoveBorrowingUserFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :borrowing_user
  end

  def down
    add_column :books, :borrowing_user, :string
  end
end

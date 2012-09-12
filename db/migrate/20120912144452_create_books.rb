class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :call_number
      t.string :title
      t.string :author
      t.integer :publication_year
      t.string :borrowing_user

      t.timestamps
    end
  end
end

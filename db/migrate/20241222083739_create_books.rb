class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :language

      t.timestamps
    end
  end
end

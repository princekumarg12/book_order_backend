class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :relative_type
      t.string :relative_name
      t.string :mobile
      t.string :gender

      t.timestamps
    end
  end
end

class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :house_no
      t.string :landmark
      t.string :village
      t.string :post_office
      t.string :tehsil
      t.string :district
      t.string :state
      t.string :city
      t.string :pin_code
      t.string :address_type
      t.boolean :is_primary

      t.timestamps
    end
  end
end

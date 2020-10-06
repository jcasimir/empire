class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.integer :sequence_number
      t.string :parcel_url
      t.string :parcel_number
      t.integer :tax_value
      t.boolean :active
      t.string :land_type
      t.integer :actual_value
      t.integer :assessed_value
      t.float :acreage
      t.string :owner_name
      t.string :owner_address

      t.timestamps
    end
  end
end

class AddNameToListingIndex < ActiveRecord::Migration[6.0]
  def change
    add_column :listing_indices, :name, :string
  end
end

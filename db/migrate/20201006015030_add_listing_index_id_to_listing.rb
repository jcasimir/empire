class AddListingIndexIdToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :listing_index_id, :integer
  end
end

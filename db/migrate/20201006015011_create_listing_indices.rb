class CreateListingIndices < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_indices do |t|

      t.timestamps
    end
  end
end

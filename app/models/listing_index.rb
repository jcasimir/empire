require 'open-uri'

class ListingIndex < ApplicationRecord
  has_many :listings
end
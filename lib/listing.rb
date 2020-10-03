class Listing
	
end

require 'nokogiri'
require 'open-uri'
require 'pry'

class ListingIndex
  
  attr_reader :source_document, :total_listings
  
  def initialize  
  end
  
  def default_url
    "https://grand.coloradotaxsale.com/index.cfm?folder=previewitems"
  end
  
  def fetch
    @source_document = Nokogiri::HTML(URI.open(default_url))
    parse
  end

  def parse
    parse_listings_count
  end
  
  def parse_listings_count
    container = source_document.at('div#paginationToolbar')
    @total_listings = container.text().match(/of (\d+) records/)[1].to_i
  end
  
end
require './lib/listing'
require 'open-uri'

class ListingIndex
  
  attr_reader :source_document, :total_listings, :listings
  include Enumerable
  
  def initialize
	@listings = []
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
	parse_listings_by_page(1)
  end
  
  def parse_listings_count
	container = source_document.at('div#paginationToolbar')
	@total_listings = container.text().match(/of (\d+) records/)[1].to_i
  end
  
  def parse_listings_by_page(number)
	container = source_document.at('table#previewResults')
	container.search('tr').each do |row|
	  valid_class = ["evenRow", "highlightRow"].include?(row.classes.first)
	  if valid_class
		@listings << parse_listing(row)
	  end
	end
  end
  
  def parse_listing(row)
	#binding.pry
	sequence_number = row.at(".advNum").text.strip
	parcel_number = row.at(".parcel").text.strip
	tax_value = row.at(".faceValue").text.strip.scan(/\d/)[0..-3].join.to_i
	active = (row.at(".previewStatus").text.strip == "Active")
	if active
	  parcel_url = row.at(".parcel a").attribute('href').value
	end
	
	Listing.new(
	  :sequence_number => sequence_number,
	  :parcel_url => parcel_url,
	  :parcel_number => parcel_number,
	  :tax_value => tax_value,
	  :active => active
	)
  end
  
  def each(&block)
	@listings.each(&block)  
  end
  
end
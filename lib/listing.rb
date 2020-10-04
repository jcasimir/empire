require 'nokogiri'
require 'open-uri'
require 'pry'
require 'mechanize'

class Listing
  attr_reader :sequence_number, :parcel_url, :parcel_number, :value, :active
  attr_reader :land_type, :actual_value, :assessed_value, :acreage
  
	def initialize(input)
    @sequence_number = input[:sequence_number]
    @parcel_url = input[:parcel_url]
    @parcel_number = input[:parcel_number]
    @value = input[:value]
    @active = input[:active]
  end
  
  def pull_deep_data
    a = Mechanize.new
    a.get(parcel_url) do |page|
      # Click the guest login button
      data_page = page.forms_with(css: 'td#middle_left form').first.submit
      
      # Now you're on the data page
      row_with_size = data_page.at('//*[@id="middle"]/table/tbody/tr[2]/td[3]/table[2]')
      @land_type = row_with_size.elements[2].elements[0].text.strip
      @actual_value = row_with_size.elements[2].elements[1].text.scan(/\d/).join.to_i
      @assessed_value = row_with_size.elements[2].elements[2].text.scan(/\d/).join.to_i
      @acreage = row_with_size.elements[2].elements[3].text.to_f
    end    
  end
end

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
    value = row.at(".faceValue").text.strip
    active = (row.at(".previewStatus").text.strip == "Active")
    if active
      parcel_url = row.at(".parcel a").attribute('href').value
    end
    
    Listing.new(
      :sequence_number => sequence_number,
      :parcel_url => parcel_url,
      :parcel_number => parcel_number,
      :value => value,
      :active => active
    )
  end
  
  def each(&block)
    @listings.each(&block)  
  end
  
end
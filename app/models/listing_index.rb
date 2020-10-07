require 'open-uri'

class ListingIndex < ApplicationRecord
  attr_reader :browser
  has_many :listings

  def default_url
    "https://grand.coloradotaxsale.com/index.cfm?folder=previewitems"
  end
  
  def fetch
    Selenium::WebDriver::Chrome::Service.driver_path = '/usr/local/bin/chromedriver'
    @browser ||= Watir::Browser.new
    browser.goto(default_url)
  end
  
  def page_count
    @page_count ||= browser.div(:id => 'paginationToolbar').text.scan(/of (\d+) \(/).join.to_i
  end
  
  def parse
    parse_current_page
    (page_count - 1).times do |i| 
      browser.execute_script("goToPage(#{i+2})")
      parse_current_page
    end
    
    listings.size
  end
  
  def parse_current_page
    ["evenRow", "highlightRow"].each do |row_class|
      rows = browser.trs(:class => row_class)
      rows.each do |row|
        parse_listing(row)
      end
    end
  end
  
  def parse_listing(row)
    sequence_number = row.td(:class => 'advNum').text.strip
    parcel_number = row.td(:class => "parcel").text.strip
    tax_value = row.td(:class => "faceValue").text.strip.scan(/\d/)[0..-3].join.to_i
    active = (row.td(:class => "previewStatus").text.strip == "Active")
    if active
      parcel_url = row.a.href
    end
    
    listings.new(
      :sequence_number => sequence_number,
      :parcel_url => parcel_url,
      :parcel_number => parcel_number,
      :tax_value => tax_value,
      :active => active
    )
  end
end
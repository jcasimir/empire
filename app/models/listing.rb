class Listing < ApplicationRecord
  # def initialize(input)
  #   @sequence_number = input[:sequence_number]
  #   @parcel_url = input[:parcel_url]
  #   @parcel_number = input[:parcel_number]
  #   @tax_value = input[:tax_value]
  #   @active = input[:active]
  #   @acreage = 0
  # end
  
  def pull_deep_data
    if parcel_url
      a = Mechanize.new
      a.get(parcel_url) do |page|
        # Click the guest login button
        data_page = page.forms_with(css: 'td#middle_left form').first.submit
        
        # Now you're on the data page
        row_with_size = data_page.at('//*[@id="middle"]/table/tbody/tr[2]/td[3]/table[2]')
        self.land_type = row_with_size.elements[2].elements[0].text.strip
        self.actual_value = row_with_size.elements[2].elements[1].text.scan(/\d/).join.to_i
        self.assessed_value = row_with_size.elements[2].elements[2].text.scan(/\d/).join.to_i
        self.acreage = if row_with_size.elements[2].elements[3]
          row_with_size.elements[2].elements[3].text.to_f
        else
          0
        end
        
        self.owner_name = data_page.at('#middle > table > tbody > tr:nth-child(2) > td:nth-child(2) > table').elements[0].children[0].children[1].text.strip
        
        self.owner_address = [1,3,5].collect do |line|
          data_page.at('#middle > table > tbody > tr:nth-child(2) > td:nth-child(2) > table').elements[1].children[0].children[line]
        end.compact.map{|v| v.text.strip}.join(", ")
      end    
    end
  end
end

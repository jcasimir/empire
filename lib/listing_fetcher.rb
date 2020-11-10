class ListingFetcher
  
  def self.get_past_guest_login_button(parcel_url)
    login_page = Mechanize.new.get(parcel_url)
    login_page.forms_with(css: 'td#middle_left form').first.submit
  end

  def self.fetch_parcel_data(parcel_url)
    return {} if parcel_url.blank?
    
    page = get_past_guest_login_button(parcel_url)
    results = {}
    
    row_with_size = page.at('//*[@id="middle"]/table/tbody/tr[2]/td[3]/table[2]')
    results[:land_type] = row_with_size.elements[2].elements[0].text.strip
    results[:actual_value] = row_with_size.elements[2].elements[1].text.scan(/\d/).join.to_i
    results[:assessed_value] = row_with_size.elements[2].elements[2].text.scan(/\d/).join.to_i
    results[:acreage] = if row_with_size.elements[2].elements[3]
      row_with_size.elements[2].elements[3].text.to_f
    else
      0
    end
    
    results[:owner_name] = page.at('#middle > table > tbody > tr:nth-child(2) > td:nth-child(2) > table').elements[0].children[0].children[1].text.strip
    
    results[:owner_address] = [1,3,5].collect do |line|
      page.at('#middle > table > tbody > tr:nth-child(2) > td:nth-child(2) > table').elements[1].children[0].children[line]
    end.compact.map{|v| v.text.strip}.join(", ")
    
    return results
  end
end
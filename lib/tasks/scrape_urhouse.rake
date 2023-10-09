require 'nokogiri'
require 'httparty'

namespace :scrape_urhouse do
  desc 'Scrape data from UrHouse website'
  task :fetch_properties => :environment do
    url = 'https://www.urhouse.com.tw/en/rentals'
    response = HTTParty.get(url)

    if response.success?
      html = Nokogiri::HTML(response.body)
      properties = []

      # Modify the following code based on the HTML structure of the website
      html.css('.property-item').each do |property_element|
        property = {
          title: property_element.css('.property-title').text.strip,
          price_per_month: property_element.css('.property-price').text.strip.to_i,
          address: property_element.css('.property-address').text.strip,
          number_of_rooms: property_element.css('.property-rooms').text.strip.to_i,
          mrt: property_element.css('.property-mrt').text.strip
        }

        properties << property
      end

      # Save properties to the database
      properties.each do |property_params|
        Property.create(property_params)
      end

      puts "#{properties.size} properties scraped and saved to the database."
    else
      puts "Failed to fetch data from #{url}. HTTP Status: #{response.code}"
    end
  end
end

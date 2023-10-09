require 'nokogiri'
require 'httparty'

namespace :scrape_urhouse do
  desc 'Scrape data from UrHouse website'
  task :fetch_properties => :environment do

    url = 'https://www.urhouse.com.tw/en/rentals'
    browser = Watir::Browser.new
    browser.goto url

    db_properties = []

    loop do
      properties = browser.elements(css: '.c-products__item').wait_until(&:present?)
      properties.each do |property|
        property = Nokogiri::HTML(property.html)

        price_per_month = property.css('.card-body_price span span h4').text.gsub(',', '').to_i
        title = property.css('.card-body_title h5').text
        address = property.css('.card-body_title p').text
        mrt = property.css('.card-body_item div')[1].text.split("\n")[0]
        number_of_rooms = property.css('.card-body_item div').first.css('span').last.text&.to_i
        db_properties << Property.new(title: title, address: address, price_per_month: price_per_month, number_of_rooms: number_of_rooms, mrt: mrt)
      end

      next_button = browser.element(css: '.pagination .fa-forward')
      break if next_button.parent.class_name.include?("disabled")
      # browser.elements(css: '.pagination .fa-forward').wait_until(&:present?)
      Watir::Wait.until { next_button.present? && next_button.enabled? }
      next_button.click
      sleep 2
    end

    Property.import db_properties
    browser.close
  end
end

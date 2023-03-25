require 'open-uri'
require 'faraday'
require 'nokogiri'
require 'mechanize'
require 'byebug'

mec_agent = Mechanize.new
page = URI.open("https://www.gazelle.com/sell/cell-phone").read

doc = Nokogiri::HTML(page)

first_brand_div = doc.css('div.transition-container').first
mobile_brands_links = first_brand_div.css('li a')
conn = Faraday.new(:url => 'https://www.gazelle.com') do |faraday|
  faraday.adapter Faraday.default_adapter
end

mobile_brands_links.each do |link|
  response = conn.get(link[:href])
  mobile_models_page = Nokogiri::HTML(response.body)

  models_links = mobile_models_page.css('div.transition-container li a')

  models_links.each do |model_link|
    response = conn.get(model_link[:href])
    carriers_links_page = Nokogiri::HTML(response.body)

    carriers_links = carriers_links_page.css('ul.level_2 li a')

    carriers_links.each do |carrier_link|

      response = conn.get(carrier_link[:href])
      memories_links_page = Nokogiri::HTML(response.body)

      memories_links = memories_links_page.css('ul.products.grid > li > a:first-child')

      memories_links.each do |memory_link|

        response = conn.get(memory_link[:href])
        offer_page = Nokogiri::HTML(response.body)





      end


    end



  end


end


#in progress refactoring to make it shorter and reuseable functions



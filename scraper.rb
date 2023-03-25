require 'open-uri'
require 'nokogiri'
require 'csv'
require 'mechanize'
require 'byebug'



# get data from web pages
def scrap_web(url)
  html = URI.open(url).read
  noko_object = Nokogiri::HTML(html)
  arr = []
  noko_object.search(".v2-listing-card__info h3").each do |el|
    arr << el.text.strip.delete("\n")
  end

  arr
end



def submit_contact_us
  agent = Mechanize.new

  # Go to the base URL
  page = agent.get("https://elevatewears.com/")


  # Find the link for the contact page and click it
  link = page.link_with(href: "https://elevatewears.com/contact/")
  page = link.click
  form = page.form(id: "wpforms-form-10")


  form["wpforms[fields][1]"] = "sample@email.com"
  form["wpforms[fields][3]"] = " test text"
  form["wpforms[fields][2]"] = "details"

  # Submit the form
  page = form.submit
  # Check the response
  page.body

end


p scrap_web('https://www.etsy.com/search?q=marvels')

submit_contact_us



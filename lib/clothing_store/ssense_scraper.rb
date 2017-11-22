require_relative "./scraper"
# Child Scraper Class for Frank and Oak
# https://www.frankandoak.com/women

class ClothingStore::SSenseScraper < ClothingStore::Scraper
  attr_reader :doc, :store, :base_url

  def initialize(store)
    @store = store
    @doc = scrape_doc_with_nokogiri(store)
    @base_url = "https://www.ssense.com"
    get_ssense_items(@doc)
  end

  def get_ssense_items(doc)
    clothing_html_containers = doc.css("figure.browsing-product-item")

    #loop through all results
    clothing_html_containers.each do |clothing|
      item = ClothingStore::Item.new

      a_tag = clothing.css("a")
      item.url = a_tag[0] && a_tag[0]["href"] ? self.base_url + a_tag[0]["href"] : ""
      item.name = clothing.css("p")[1].text
      item.price = "CAD " + clothing.css("p.price span").text
      item.brand = clothing.css("p")[0].text

      @store.add_clothing_item(item)
    end

    @store.display_clothing_items
    items = @store.get_clothing_items

    get_users_clothing_choice(items)
  end

  def scrape_ssense_item(item)
    item_page = scrape_doc_with_nokogiri(item)
    # get extra product details
    # on the ssense website the details are hidden on the individual item pages so grab it from a meta tag
    details = item_page.at("meta[name='twitter:description']")["content"]

    # <meta name="twitter:description" content="Low-top buffed leather sneakers in white. Round toe. Tonal lace-up closure. Logo stamp in silver-tone at padded tongue. Padded collar. Perforated detailing at sides.">

    details = details.split(". ")
    # add each product detail to the item's "general details" attr
    details.each {|detail| item.general_details << detail}
  end

end

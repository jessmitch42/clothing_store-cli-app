require_relative "./scraper"
# Child Scraper Class for Frank and Oak
# https://www.frankandoak.com/women

class ClothingStore::SSenseScraper < ClothingStore::Scraper
  attr_reader :doc, :store

  def initialize(store)
    @store = store
    @doc = scrape_doc_with_nokogiri(store)
    get_ssense_items(@doc)
  end

  def get_ssense_items(doc)
    puts doc
    clothing_html_containers = doc.css("figure.browsing-product-item")

    puts clothing_html_containers[0]
    #loop through all results
    clothing_html_containers.collect do |clothing|
      # item = ClothingStore::Item.new

      # a_tag = clothing.css("a.product-tile__link")
      # item.url = a_tag[0] && a_tag[0]["href"] ? base_url + a_tag[0]["href"] : ""
      # item.name = clothing.css(".tile__detail--name").text
      # item.price = clothing.css(".tile__detail--price--list").text
      # item.brand = name
      #
      # @store.add_clothing_item(item)
    end

    # @store.display_clothing_items
    # items = @store.get_clothing_items
    #
    # get_users_clothing_choice(items)
  end

  def scrape_specific_ssense_item(item)
    item_page = scrape_doc_with_nokogiri(item)
    # get extra product details
    details = item_page.css("ul.bullet-list li")
    # add each product detail to the item's "general details" attr
    details.each {|detail| item.general_details << detail.text}
  end

end

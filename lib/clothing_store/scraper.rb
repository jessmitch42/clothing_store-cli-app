class ClothingStore::Scraper
  # Current options:
  # https://www.ssense.com/en-ca/women/clothing
  # https://www.jcrew.com/ca/c/womens_special_sizes/tall
  # https://www.frankandoak.com/women

  attr_reader :store, :name, :url

  def initialize(store)
    @store = store
    @name = store.name
    @url = store.url
    choose_scraper_by_name
  end

  def choose_scraper_by_name
    # case statement to choose which scraper to use (three options)
    # if somehow a different option got let in, panic and start the program over.

    case self.name
    when "JCrew"
      scrape_jcrew_main_page
    when "SSENSE"
      scrape_ssense_main_page
    when "Frank and Oak"
      scrape_frank_and_oak_main_page
    else
      puts "Um.. this is embarrassing. Something went wrong so I'm sending you back to the beginning."
      ClothingStore::CLI.new.call
    end
  end

  def waiting_msg(store_name)
    puts
    puts "This should only take a second or two..."
    # puts "Collecting data from #{store_name}..."
  end

  def scrape_jcrew_main_page
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)

    clothing_containers = doc.css(".product-tile--info")
    base_url = "https://www.jcrew.com"

    clothing_containers.each do |clothing|
      item = ClothingStore::Item.new

      a_tag = clothing.css("a.product-tile__link")
      item.url = a_tag[0] && a_tag[0]["href"] ? base_url + a_tag[0]["href"] : ""
      item.name = clothing.css(".tile__detail--name").text
      item.price = clothing.css(".tile__detail--price--list").text
      item.brand = self.name

      @store.add_clothing_item(item)
    end

    @store.display_clothing_items
  end

  def list_jcrew_items

  end

  def get_users_jcrew_clothing_choice

    puts

  end

  def scrape_jcrew_item(item)

  end

  def scrape_ssense_main_page
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)
  end

  def scrape_frank_and_oak_main_page
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)
  end


end

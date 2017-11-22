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
    doc = scrape_doc_with_nokogiri

    case self.name
    when "JCrew"
      get_jcrew_items(doc)
    when "SSENSE"
      get_ssense_items(doc)
    when "Frank and Oak"
      get_frank_and_oak_items(doc)
    else
      puts "Um.. this is embarrassing. Something went wrong so I'm sending you back to the beginning."
      ClothingStore::CLI.new.call
    end
  end

  def scrape_doc_with_nokogiri
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)
  end

  def waiting_msg(store_name)
    puts
    puts "This should only take a second or two..."
  end

  def get_jcrew_items(doc)

    clothing_containers = doc.css(".product-tile--info")
    base_url = "https://www.jcrew.com" # required for setting url below

    #loop through all results
    clothing_containers.collect do |clothing|
      item = ClothingStore::Item.new

      a_tag = clothing.css("a.product-tile__link")
      item.url = a_tag[0] && a_tag[0]["href"] ? base_url + a_tag[0]["href"] : ""
      item.name = clothing.css(".tile__detail--name").text
      item.price = clothing.css(".tile__detail--price--list").text
      item.brand = self.name

      @store.add_clothing_item(item)
    end

    @store.display_clothing_items
    items = @store.get_clothing_items

    get_users_clothing_choice(items)
  end

  def get_users_clothing_choice(items)
    puts

    if items.length > 0
      puts "Please choose an item by the corresponding number (e.g. '3') or 'exit' to leave"
      item_choice = gets.strip
      item_choice = item_choice.to_i

      if item_choice > 0 && item_choice <= items.length
        #scrape for indiivudal item
        scrape_specific_jcrew_item(items[item_choice - 1])
      else
        puts "Oops! Looks like an invalid choice."
        get_users_clothing_choice(items)
      end
    else
      puts "Looks like there are no clothes to look at so.. game over, bye!! ¯\_(ツ)_/¯"
    end

  end

  def scrape_specific_jcrew_item(item)
    puts "heerrreee"
  end

  def get_ssense_items(doc)
  end

  def get_frank_and_oak_items(doc)
  end


end

class ClothingStore::Scraper
  # Current options:
  # https://www.jcrew.com/ca/c/womens_special_sizes/tall
  # https://www.frankandoak.com/women

  attr_reader :store, :name, :url, :doc

  def initialize(store)
    @store = store
    @name = store.name
    @url = store.url
  end

  def scrape_doc_with_nokogiri(store)
    waiting_msg(store.name)

    html = open(store.url)
    doc = Nokogiri::HTML(html)
  end

  def waiting_msg(store_name)
    puts
    puts "This should only take a second or two..."
  end

  def get_users_clothing_choice(items)
    puts

    if items.length > 0
      puts "Please choose an item by the corresponding number (e.g. '3') or 'exit' to leave"
      item_choice = gets.strip
      item_choice = item_choice.to_i

      if item_choice > 0 && item_choice <= items.length
        # scrape for indiivudal item
        clothing_item_obj = items[item_choice - 1]
        # second-level scrape
        scrape_specific_jcrew_item(clothing_item_obj)
        # display item details
        clothing_item_obj.display_item_details
      else
        puts "Oops! Looks like an invalid choice."
        get_users_clothing_choice(items)
      end
    else
      puts "Looks like there are no clothes to look at so.. game over, bye!! ¯\_(ツ)_/¯"
      exit
    end

  end


end

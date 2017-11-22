# Parent Scraper Class

class ClothingStore::Scraper
  attr_reader :store, :name, :url, :doc

  def initialize(store)
    @store = store
    @name = store.name
    @url = store.url
  end

  def scrape_doc_with_nokogiri(instance)
    waiting_msg(instance.name)

    html = open(instance.url)
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
        # retrieve item instance that the user selected
        clothing_item_instance = items[item_choice - 1]
        # second-level scrape of selected item
        determine_and_run_item_scraper(clothing_item_instance)
        # display item details
        clothing_item_instance.display_item_details
        # user chooses next step
        open_item_url_or_go_back(clothing_item_instance.url)
      else
        puts "Oops! Looks like an invalid choice."
        get_users_clothing_choice(items)
      end
    else
      puts "Looks like there are no clothes to look at so.. game over, bye!! ¯\_(ツ)_/¯"
      exit
    end

  end

  def determine_and_run_item_scraper(item)
    self.store.name == "JCrew" ? scrape_jcrew_item(item) : scrape_ssense_item(item)
  end

  def open_item_url_or_go_back(url)
    puts
    puts "Interested in buying this item? Enter 'open' to see it in the browser or 'back' to return to the list"

    input = gets.strip

    case input.downcase
    when "exit"
      puts "See you later!"
      exit
    when "open"
      puts "Opening your item!"
      system("open", url)
    when "back"
      puts "do something"
    else
      puts "Please choose 'open', 'back', or 'exit'. :)"
      open_item_url_or_go_back(url)
    end

  end

end

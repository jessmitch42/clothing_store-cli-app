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
    puts "Please choose an item by the corresponding number (e.g. '3') or 'exit' to leave or 'back' to choose a new store."

    item_choice = gets.strip
    item_choice_int = item_choice.to_i

    if item_choice_int > 0 && item_choice_int <= items.length
      # retrieve item instance that the user selected
      clothing_item_instance = items[item_choice_int - 1]
      # second-level scrape of selected item
      determine_and_run_item_scraper(clothing_item_instance)
      # display item details
      clothing_item_instance.display_item_details
      # user chooses next step
      open_item_url_or_go_back(clothing_item_instance.url)
    elsif item_choice == "exit"
      "Byyyeeee!!! ¯\_(ツ)_/¯"
      exit
    elsif item_choice == "back"
      puts "Starting over!"
      self.store.cli.list_store_options
    else
      puts "Oops! Looks like an invalid choice. Try again."
      get_users_clothing_choice(items)
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
      self.store.display_clothing_items
      items = self.store.get_clothing_items

      get_users_clothing_choice(items)
    else
      puts "Please choose 'open', 'back', or 'exit'. :)"
      open_item_url_or_go_back(url)
    end

  end

end

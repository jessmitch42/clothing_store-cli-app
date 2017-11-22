# Parent Scraper Class

class ClothingStore::Scraper
  attr_reader :store, :name, :url, :doc

  def initialize(store)
    @store = store
    @name = store.name
    @url = store.url
  end

  def scrape_doc_with_nokogiri(instance)
    waiting_msg

    html = open(instance.url)
    doc = Nokogiri::HTML(html)
  end

  def waiting_msg
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
      item_instance = items[item_choice_int - 1]
      # second-level scrape of selected item; store dependent
      item_scraper(item_instance)
      # display item details
      item_instance.display_item_details
      # user chooses next step
      item_instance.open_item_url_or_go_back
    elsif item_choice == "exit"
      puts"Byyyeeee!!! ¯\\_(ツ)_/¯"
      exit
    elsif item_choice == "back"
      puts "Starting over!"
      self.store.cli.list_store_options
    else
      puts "Oops! Looks like an invalid choice. Try again."
      get_users_clothing_choice(items)
    end
  end

end

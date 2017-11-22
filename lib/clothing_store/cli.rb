#CLI Controller

class ClothingStore::CLI

  def call
    intro_message
    create_stores
    list_store_options
  end

  def intro_message
    # INTRO MESSAGE w/ line breaks
    puts
    puts "***********************************"
    puts "**                               **"
    puts "**            WELCOME!           **"
    puts "**                               **"
    puts "***********************************"
    puts

    # ADDITIONAL INFO
    puts "Welcome to my clothing store gem!"
    puts "Use this program to see what clothes are for sale from a variety of stores."
    puts "Check out the details and open the product directly in your browser if you're ready to buy it. :)"
    puts "Leave the program at any time by entering 'exit'."
    puts
  end

  def create_stores
    jcrew = ClothingStore::Store.new("JCrew")
    jcrew.url = "https://www.jcrew.com/ca/c/womens_special_sizes/tall"

    ssense = ClothingStore::Store.new("SSENSE")
    ssense.url = "https://www.ssense.com/en-ca/women"
  end

  def list_store_options
    puts "Let's get started!"
    puts "Below you'll see a few online clothing stores. Select one by entering the corresponding number."

    #loop through stores (Stores.all)
    stores = ClothingStore::Store.all
    stores.each.with_index(1) { |store, index| puts "#{index}. #{store.name}" }

    get_users_store_choice(stores)
  end

  def get_users_store_choice(stores)
    store_selection = gets.strip
    selection_to_i = store_selection.to_i

    if store_selection == "exit"
      exit
    elsif selection_to_i > 0 && selection_to_i <= stores.length
      user_store_choice = stores[selection_to_i - 1]
      get_store_info_with_scraper(user_store_choice)
    else
      puts "Eek! That's an invalid option. Please choose a store. (eg. '1')"
      # self-reference user input "get" until they give a valid input
      get_users_store_choice(stores)
    end
  end

  def get_store_info_with_scraper(user_store_selection)
    store_name = user_store_selection.name
    store_url = user_store_selection.url

    puts
    puts "Getting the clothing listing for #{store_name}..."
    puts "Using the URL: #{store_url}"

    if store_name == "JCrew"
      clothing_list_scraper = ClothingStore::JCrewScraper.new(user_store_selection)
    else
      clothing_list_scraper = ClothingStore::SSenseScraper.new(user_store_selection)
    end
  end

end

# message to user
# let them know to type "exit" at any point to exit the program
# first pick a store you want to look at
# scrape info (first level) from the store (don't permanently save it in case it changes)
# first level info: product name, brand, whatever is available on general list page (keep it brief for list view)
# second level info: product name, description, price, any specific data for individual item
  # needs the option to ask "is it poly?" to give yes or no answer
# "back" command to go level up?

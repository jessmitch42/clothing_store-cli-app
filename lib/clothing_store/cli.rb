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
    puts "Let's get started!"
  end

  def create_stores
    jcrew = ClothingStore::Store.new("JCrew")
    jcrew.url = "https://www.jcrew.com/ca/c/womens_special_sizes/tall"
    jcrew.cli = self

    ssense = ClothingStore::Store.new("SSENSE")
    ssense.url = "https://www.ssense.com/en-ca/women"
    ssense.cli = self
  end

  def list_store_options
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
      user_store_choice.get_store_info_with_scraper
    else
      puts "Eek! That's an invalid option. Please choose a store. (eg. '1')"
      # self-reference user input "get" until they give a valid input
      get_users_store_choice(stores)
    end
  end


end

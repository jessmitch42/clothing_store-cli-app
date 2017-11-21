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
    ssense.url = "https://www.ssense.com/en-ca/women/clothing"

    frank_and_oak = ClothingStore::Store.new("Frank and Oak")
    frank_and_oak.url = "https://www.frankandoak.com/women"
  end

  def list_store_options
    puts "Let's get started!"
    puts "Below you'll see a few online clothing stores. Select one by entering the corresponding number."

    #loop through stores (Stores.all)
    stores = ClothingStore::Store.all
    stores.each.with_index(1) { |store, index| puts "#{index}. #{store.name}" }

    # store_selection = gets.strip


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

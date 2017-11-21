#CLI Controller

class ClothingStore::CLI

  def call
    intro_message
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
end

# message to user
# let them know to type "exit" at any point to exit the program
# first pick a store you want to look at
# scrape info (first level) from the store (don't permanently save it in case it changes)
# first level info: product name, brand, whatever is available on general list page (keep it brief for list view)
# second level info: product name, description, price, any specific data for individual item
  # needs the option to ask "is it poly?" to give yes or no answer
# "back" command to go level up?

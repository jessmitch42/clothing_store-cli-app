#CLI Controller

class ClothingStore::CLI

  def call
    # INTRO MESSAGE

    puts "Welcome to 'Is It Poly?'"
    puts "Use this program to see what clothes are for sale from a variety of stores."
    puts "If it looks like a great piece of clothing"
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

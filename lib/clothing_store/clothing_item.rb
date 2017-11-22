class ClothingStore::Item
  attr_accessor :name, :price, :url, :brand, :general_details, :store, :scraper

  def initialize
    @general_details = []
  end

  def display_item_details
    # loop through details array to show extra item info
    puts
    puts "About the '#{self.name}' by #{self.brand}:"
    self.general_details.each.with_index(1) {|detail, index| puts "#{index}. #{detail}"}
  end

  def open_item_url_or_go_back
    puts
    puts "Interested in buying this item? Enter 'open' to see it in the browser or 'back' to return to the list."
    puts "(Over it? Enter 'exit' to leave.)"

    input = gets.strip

    case input.downcase
    when "exit"
      puts "See you later!"
      exit
    when "open"
      puts "Opening your item!"
      system("open", self.url)
    when "back"
      puts "do something"
      self.store.display_store_items
      items = self.store.get_clothing_items

      self.scraper.get_users_clothing_choice(items)
    else
      puts "Please choose 'open', 'back', or 'exit'. :)"
      open_item_url_or_go_back
    end
  end

end

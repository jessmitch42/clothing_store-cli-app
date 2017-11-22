class ClothingStore::Item
  attr_accessor :name, :price, :url, :brand, :general_details

  def initialize
    @general_details = []
  end

  def display_item_details
    # loop through details array to show extra item info
    puts
    puts "About '#{self.name}':"
    self.general_details.each.with_index(1) {|detail, index| puts "#{index}. #{detail}"}
  end

end

class ClothingStore::Store

  attr_accessor :name, :url, :clothing_items

  @@all = [] # track stores that have been scraped so fair

  def initialize(name)
    @name = name
    # scrape clothing options, set to clothing pieces
    @@all << self
    @clothing_items = []
  end

  def self.all
    @@all
  end

  def add_clothing_item(item)
    @clothing_items << item
  end

  def display_clothing_items
    @clothing_items.each.with_index(1) do |item, index|
      puts "#{index}. #{item.name} - #{item.price}"
    end
  end

end

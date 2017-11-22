class ClothingStore::Store
  attr_accessor :name, :url, :clothing_items, :cli

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

  def get_clothing_items
    @clothing_items
  end

  def get_store_info_with_scraper
    store_name = self.name
    store_url = self.url

    puts
    puts "Getting the clothing listing for #{store_name}..."
    puts "Using the URL: #{store_url}"

    if store_name == "JCrew"
      clothing_list_scraper = ClothingStore::JCrewScraper.new(self)
    else
      clothing_list_scraper = ClothingStore::SSenseScraper.new(self)
    end
  end

end

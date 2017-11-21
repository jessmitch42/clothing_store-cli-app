class ClothingStore::Store

  attr_accessor :name, :url

  @@all = [] # track stores that have been scraped so fair

  def initialize(name)
    @name = name
    # scrape clothing options, set to clothing pieces
    @@all << self
  end

  def self.all
    @@all
  end

end

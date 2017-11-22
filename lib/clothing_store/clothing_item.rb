class ClothingStore::Item
  attr_accessor :name, :price, :url, :brand, :rating
  # 
  # @@all = []
  #
  # def initialize
  #   @@all << self
  # end
  #
  # def self.all
  #   @@all
  # end
  #
  # def self.get_list_by_brand(brand)
  #   @@all.collect {|item| item.brand == brand}
  # end

end

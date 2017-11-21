class ClothingStore::Scraper
  # Current options:
  # https://www.ssense.com/en-ca/women/clothing
  # https://www.jcrew.com/ca/c/womens_special_sizes/tall
  # https://www.frankandoak.com/women

  attr_reader :store, :name, :url

  def initialize(store)
    @store = store
    @name = store.name
    @url = store.url
    choose_scraper_by_name
  end

  def choose_scraper_by_name
    # case statement to choose which scraper to use (three options)
    # if somehow a different option got let in, panic and start the program over.

    case self.name
    when "JCrew"
      scrape_jcrew_main_page
    when "SSENSE"
      scrape_ssense_main_page
    when "Frank and Oak"
      scrape_frank_and_oak_main_page
    else
      puts "Um.. this is embarrassing. Something went wrong so I'm sending you back to the beginning."
      ClothingStore::CLI.new.call
    end
  end

  def waiting_msg(store_name)
    puts
    puts "This should only take a second or two..."
    # puts "Collecting data from #{store_name}..."
  end

  def scrape_jcrew_main_page
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)

    clothing_containers = doc.css(".product-tile--info")
    puts clothing_containers[0]
    # clothing_containers.each do |item|
    #
    # end
  end

  def scrape_ssense_main_page
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)
  end

  def scrape_frank_and_oak_main_page
    waiting_msg(self.name)

    html = open(self.url)
    doc = Nokogiri::HTML(html)
  end


end

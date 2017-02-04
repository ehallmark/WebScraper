class Product < ActiveRecord::Base


  def self.seedProducts
    base_url = "http://www.amazon.com/s/field-keywords="
    base_uri = URI.parse(URI.escape(base_url))

    semaphore = Mutex.new # For multithreading
    threads = []
    puts "STARTING TO STREAM..."

    # Set up HTTP Streaming
    Net::HTTP.start(base_uri.host, base_uri.port) do |http|

      # List all possible nums
      ["chair"].each do |keyword|

        url = [base_url,"#{keyword}"].join # Generate URL
        uri = URI.parse(URI.escape(url))

        puts "URL FOR: ",url

        request = Net::HTTP::Get.new uri
        results = http.request request

        puts results.body.inspect

        puts "Successful?"
        puts results.kind_of? Net::HTTPSuccess
        next unless results.kind_of? Net::HTTPSuccess

        puts "SUCCESSFULLY FOUND: #{keyword}"

      end
    end
    threads.each do |t| t.join end
  end
end

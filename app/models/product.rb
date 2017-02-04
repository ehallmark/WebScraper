class Product < ActiveRecord::Base


  def self.seedProducts
    base_url = "https://www.amazon.com/s/field-keywords="
    base_uri = URI.parse(URI.escape(base_url))

    semaphore = Mutex.new # For multithreading
    threads = []
    puts "STARTING TO STREAM..."

    # Set up HTTP Streaming
      # List all possible nums
      ["chair"].each do |keyword|

        url = [base_url,"#{keyword}"].join # Generate URL
        uri = URI.parse(URI.escape(url))

        puts "URL FOR: ",url

        request = uri.request_uri
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request.add_field('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0')
        request.add_field('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
        results = http.get(request)

        puts results.body.inspect

        puts "Successful?"
        puts results.kind_of? Net::HTTPSuccess
        next unless results.kind_of? Net::HTTPSuccess

        puts "SUCCESSFULLY FOUND: #{keyword}"
      end
    threads.each do |t| t.join end
  end
end

# frozen_string_literal: true
require 'nokogiri'
require 'net/http'
require 'csv'

def amazon_crawl(search_query, prods)
  base_url = "https://www.amazon.com/s?k="

  25.times do |i| # Will scrape 5 pages
    search_url = base_url + search_query.gsub(" ", "+") + "&page=#{i+1}"

    uri = URI(search_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request['User-Agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"

    response = http.request(request)
    html_content = response.body

    doc = Nokogiri::HTML(html_content)

    product_containers = doc.css('div.s-result-item')
    product_containers.each do |container|
      product_name = container.css('span.a-text-normal').text.strip
      product_price = container.css('span.a-price span.a-offscreen').first&.text # Select the first price encountered

      next if product_name.empty? || product_price.nil? # Skip if product name is empty or no price found

      prods[product_name] = product_price
    end

    puts "Processed page #{i + 1}/25"
  end
end

def sort_results(results)
  # Check if 'product_price' is nil and substitute it with a value that doesn't affect the sorting order
  sorted_results = results.sort_by { |_product_name, product_price| (product_price ? product_price.gsub('$', '') : '0').to_f }
  sorted_results.to_h
end

def results_to_csv(results)

  CSV.open('./SearchResults/results.csv', 'a') do |csv|
    csv << ['Product', 'Price']
    results.each do |product, price|
      csv << [product, price]
    end
  end
end



# search_query = "Candy"
# products = {}
#
# amazon_crawl(search_query, products)
# sorted_products = sort_results(products)
# puts "Total number of products: #{sorted_products.length}"
#
# results_to_csv(sorted_products)

# frozen_string_literal: true
require 'nokogiri'
require 'net/http'
require 'csv'

=begin
Crawl Amazon to find the first 25 pages of results related to the search query.

search_query - the item to search for.
prods - the hash that will store the items from the crawl.

container.css('span.a-text-normal').text.strip - the products name.
container.css('span.a-price span.a-offscreen').first&.text - the products price.


=end
def amazon_crawl(search_query, prods)
  base_url = "https://www.amazon.com/s?k="

  25.times do | i |
    # Attempt to grab the first 25 pages.
    search_url = base_url + search_query.gsub(" ", "+") + "&page=#{i + 1}"

    uri          = URI(search_url)
    http         = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request               = Net::HTTP::Get.new(uri.request_uri)

    # add a more human like user agent to the header so crawler is able to run
    request['User-Agent'] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"

    response     = http.request(request)
    html_content = response.body

    doc = Nokogiri::HTML(html_content)


    doc.css('div.s-result-item').each do | container |

      product_name = container.css('span.a-text-normal').text.strip
      product_price = container.css('span.a-price span.a-offscreen').first&.text
      prods[product_name] = product_price

      # skip iterations that produce an item with no name, or no price.
      next if product_name.empty? || product_price.nil?

    end

    puts "Processed page #{i + 1}/25"
  end
end

=begin
Sort the search results by lowest price

Return the sorted results as a hash.
=end
def sort_results(results)
  sorted_results = results.sort_by { | _product_name, product_price | (product_price ? product_price.gsub('$', '') : '0').to_f }
  sorted_results.to_h
end

=begin
convert the crawlers results to CSV format then store it
=end
def results_to_csv(results)

  CSV.open('./SearchResults/results.csv', 'a') do | csv |
    csv << ['Product', 'Price']
    results.each do | product, price |
      csv << [product, price]
    end
  end
end





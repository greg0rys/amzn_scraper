# frozen_string_literal: true
require 'time'
require_relative "Crawlers/amazon_scraper"
require_relative 'Helpers/read_csv'

def main

  startT = endT = 0
  puts "What would you like to find? "
  search_query = gets.chomp

  puts "How many pages should I crawl? "
  num_pages = gets.chomp.to_i
  prods        = {} # store all of the products in a hash to perform transformations

  # start the timer, see how longer the crawl takes
  # anything added after the amazon_crawl statement will obsure the results
  # it will cound the time it takes to do whatever assignment
  startT = Time.now
  # add no code here
  amazon_crawl(search_query, prods,num_pages)

  # add no code here
  # here is the end time
  endT = Time.now

  # add new code below this line
  sorted_results = sort_results(prods)
  results_to_csv(sorted_results) # write the results to a file to perform some type of caching

  # iterate over the CSV file to build a Product object. e.x

  prod_holder = {}

  sorted_results.each do |k,v|
    prod_holder[k] = v
  end

  puts "\e[31mCompiled #{prod_holder.length} results for #{search_query.capitalize} from the crawl."
  puts "\e[32mTook #{(endT - startT).round(2)} seconds\n * This includes the Crawl & CSV Conversion"
end

## Run the crawler with an assistive timer to get a true feel for O(n)
# @param query the item we wish to search for
# @param prods a hash that we will store the resulting products in
# @param num_results the number of pages we want to scrape
# @return the total time it took to do the crawl.
def time_crawl(query, prods, num_results)


  start_time = Time.now

  amazon_crawl query, prods, num_results

  end_time = Time.now

  (end_time - start_time).round(2)

end

main
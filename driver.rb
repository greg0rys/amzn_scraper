# frozen_string_literal: true
require 'time'
require_relative "Crawlers/amazon_scraper"
require_relative 'Helpers/read_csv'

def main

  startT = 0
  endT = 0
  puts "What would you like to find? "
  search_query = gets.chomp
  prods        = {} # store all of the products in a hash to perform transformations

  # start the timer, see how longer the crawl takes
  startT = Time.now
  amazon_crawl(search_query, prods)

  # here is the end time
  endT = Time.now

  sorted_results = sort_results(prods) # sort the result by price.
  results_to_csv(sorted_results) # write the results to a file to perform some type of cahcing
  puts "Total number of products: #{sorted_results.length}"

  # iterate over the CSV file to build a Product object. e.x

  prod_holder = {}

  sorted_results.each do |k,v|
    prod_holder[k] = v
  end

  puts "Compiled #{prod_holder.length} objects form the crawl. "
  puts "Took #{(endT - startT).round(2)} seconds"
end

main
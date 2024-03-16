# frozen_string_literal: true
require_relative 'amazon_scraper'
require_relative 'read_csv'
require_relative 'product'

def main

  puts "What would you like to find? "
  search_query = gets.chomp
  prods        = {} # store all of the products in a hash to perform transformations
  amazon_crawl(search_query, prods)

  sorted_results = sort_results(prods) # sort the result by price.
  results_to_csv(sorted_results) # write the results to a file to perform some type of cahcing
  puts "Total number of products: #{sorted_results.length}"

  # iterate over the CSV file to build a Product object. e.x

  prod_holder = {}

  sorted_results.each do |k,v|
    prod_holder[k] = v
  end

  puts "Compiled #{prod_holder.length} objects form the crawl. "
end

main
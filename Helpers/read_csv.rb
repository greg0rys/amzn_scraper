# frozen_string_literal: true
require 'csv'
def remove_quotes_from_csv(file_name)
  text = File.read(file_name)
  new_content = text.gsub('"', '')  # replace " with nothing

  File.open(file_name, 'w') { |file| file.puts new_content }
end

File.foreach("SearchResults/results.csv") do |row|
  i = 0
  parts = row.strip.split(',')
  price = parts.pop&.strip
  title = parts.shift&.strip&.slice(0,55)  # Only allow first 25 characters
  description = parts.join(',').strip

  # p = Product.new(title,price)
  # puts "The Title: #{p.get_name}"

  # puts "Title: #{title}"
  # puts "Description: #{description}"
  # puts "Price: #{price}"
  # puts "------"
end
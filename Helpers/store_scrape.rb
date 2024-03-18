# frozen_string_literal: true

require 'mysql2'
require 'dotenv'


begin
  Dotenv.load
  host = ENV['HOST']
  username = ENV['USER']
  password = ENV['PASSWORD']
  db_name = ENV['DB_NAME']
  client = Mysql2::Client.new(:host => "#{host}", :username => "#{username}",:password => "#{password}" ,
                              :database =>
    "db_name")

  results = client.query("SELECT * FROM table_name")

  results.each do |row|
    puts row
  end

rescue Mysql2::Error => e
  puts e.errno
  puts e.error

ensure
  client.close if client
end

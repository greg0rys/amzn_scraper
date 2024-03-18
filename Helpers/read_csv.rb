# frozen_string_literal: true
require 'csv'

# @author Greg Shenefelt
# @version 03.17.24
# @since 03.15.24
# @note Designed to read and modify CSV files.


# Remove the quotes from CSV lines - This will remove quotes from the whole file.
# @author greg0rys
# @param file_name - the name of the file we want to remove quotes from
# @return nil
def remove_quotes_from_csv(file_name)
  text = File.read(file_name)
  new_content = text.gsub('"', '')  # replace " with nothing

  File.open(file_name, 'w') { |file| file.puts new_content }
end

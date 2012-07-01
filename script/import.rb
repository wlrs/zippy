require 'csv'
require 'pp'

columns = nil

CSV.foreach("../source/free-zipcode-database.csv") do |row|
  if !columns
    columns = row
    next
  end

  zip = {}

  columns.each_with_index { |col, index| zip[col] = row[index] }
  pp zip

end
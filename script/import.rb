require 'csv'
require 'pp'
require 'mysql'

columns = nil
db = Mysql.real_connect('localhost', 'root', '', 'zippy')


CSV.foreach("../source/free-zipcode-database.csv") do |row|
  if !columns
    columns = row
    next
  end

  zip = {}

  columns.each_with_index do |col, index|
    zip[col.downcase] = db.quote(row[index]) if row[index]
  end

  puts "#{zip['zipcode']} - #{zip['city']}, #{zip['state']}"

  db.query("insert into `zips` (`zip`, `city`, `state`, `updated`) VALUES ('#{zip['zipcode']}', '#{zip['city']}', '#{zip['state']}', now())")

end
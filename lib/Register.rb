require 'Student'
require 'Database'

class Register
    def self.drawmenu
        puts "xd"
        puts "xd"
    end
end



Register.drawmenu


Database.init
Database.db.execute "DELETE FROM Student"

Database.add Student.new("jan" , "kowalski" )
Database.add Student.new("ktos" , "ktosiowski" )

s = Student.new("ktos" , "ktosiowskowaty" )
s.setid(1)

Database.update s

puts Database.db.execute "SELECT * FROM Student"



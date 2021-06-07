require 'pg'
require 'hanami/controller'

module CreateTable
    class CreateTable
        include ::Hanami::Action
        def call (env)
            begin
                con = PG.connect :host => 'ec2-3-234-22-132.compute-1.amazonaws.com', :dbname => 'd1re1k2rplt7t2', :user => 'sewuvljklsqoqu', :password => '18f0134f286951799b72989aaf762d0ef926afad65d2c9e6f7c959aa991b1246'
                exist = con.exec "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'emp')"
                
                if exist[0]["exists"]=='t' 
                    con.exec "CREATE TABLE emp(Name VARCHAR(20), Email VARCHAR(30) PRIMARY KEY, Password VARCHAR(20), EmpCode VARCHAR(20), Address VARCHAR(50), JoiningDate  VARCHAR(20))"
                    puts "Table Created"
                else
                    puts "Table Exist"
                end
            
            rescue PG::Error => e
            
                puts e.message 
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 

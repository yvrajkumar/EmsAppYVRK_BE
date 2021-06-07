require 'pg'
require 'hanami/controller'
require 'json'

module SignIn
    class SignIn
        include ::Hanami::Action
        def call (env)
            response = "#{ env[] }"
            puts response
            puts "HI"
            signinDetails = JSON.parse(response)
            puts "HI"
            email = signinDetails['signinDetails']['email']
            password = signinDetails['signinDetails']['password']
            
            begin
                con = PG.connect :host => 'ec2-3-234-22-132.compute-1.amazonaws.com', :dbname => 'd1re1k2rplt7t2', :user => 'sewuvljklsqoqu', :password => '18f0134f286951799b72989aaf762d0ef926afad65d2c9e6f7c959aa991b1246'
                exist = con.exec "select exists (select * from emp where email='#{email}' and password='#{password}')"

                if exist[0]["exists"]=='t' 
                    puts "Existing User"

                    empDetails = con.exec "select * from emp where email='#{email}' and password='#{password}'"

                    validation = "true"
                    name = empDetails[0]["name"]
                    email = empDetails[0]["email"]
                    password = empDetails[0]["password"]
                    empcode = empDetails[0]["empcode"]
                    address = empDetails[0]["address"]
                    joiningdate = empDetails[0]["joiningdate"]
                    
                    response = {'validation' => validation, 'name' => name, 'email' => email, 'password' => password, 'empcode' => empcode, 'address' => address, 'joiningdate' => joiningdate}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else
                    puts "Wrong User Details"
                    validation = "false"
                                      
                    response = {'validation' => validation}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end
                
            
            rescue PG::Error => e
            
                puts e.message 
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 

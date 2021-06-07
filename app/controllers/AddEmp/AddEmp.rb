require 'pg'
require 'hanami/controller'
require 'json'

module AddEmp
    class AddEmp
        include ::Hanami::Action
        def call (env)
            puts "add emp"
            puts request.body.read()
            req = request.body.read()
            signupDetails = req
            name = signupDetails['signupDetails']['name']
            email = signupDetails['signupDetails']['email']
            password = signupDetails['signupDetails']['password']
            empcode = signupDetails['signupDetails']['empcode']
            address = signupDetails['signupDetails']['address']
            joiningdate = signupDetails['signupDetails']['joiningdate']
            begin
                con = PG.connect :host => 'ec2-3-234-22-132.compute-1.amazonaws.com', :dbname => 'd1re1k2rplt7t2', :user => 'sewuvljklsqoqu', :password => '18f0134f286951799b72989aaf762d0ef926afad65d2c9e6f7c959aa991b1246'
                
                existingUser = con.exec "select exists (select * from emp where email='#{email}')"
                puts existingUser
                if existingUser[0]["exists"]==='f' 
                    exist = con.exec "INSERT INTO emp values ('#{name}', '#{email}', '#{password}', '#{empcode}', '#{address}', '#{joiningdate}')"
                    puts "Emp Added"
                    result = "Account Created"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else 
                    result = "Existing User"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end  
            
            rescue PG::Error => e
            
                puts e.message 

                puts "Emp Not Added"
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 

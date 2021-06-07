require 'pg'
require 'hanami/controller'
require 'json'

module DeleteProfile
    class DeleteProfile
        include ::Hanami::Action
        def call (env)
            request.body.rewind
            response = request.body.read
            puts response
            deleteProfileDetails = JSON.parse(response)
            email = deleteProfileDetails['profileDetails']['email']
            puts email
            
            begin
                
                con = PG.connect :host => 'ec2-3-234-22-132.compute-1.amazonaws.com', :dbname => 'd1re1k2rplt7t2', :user => 'sewuvljklsqoqu', :password => '18f0134f286951799b72989aaf762d0ef926afad65d2c9e6f7c959aa991b1246'
                exist = con.exec "DELETE FROM emp where email = '#{email}'"
                
                    puts "Profile Is Deleted"

                    deleted = "true"
                                        
                    response = {'deleted' => deleted}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res              
                
            
            rescue PG::Error => e
            
                puts e.message 

                    updated = "false"
                                      
                    response = {'updated' => updated}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 

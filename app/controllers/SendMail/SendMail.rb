require 'pg'
require 'hanami/controller'
require 'json'
require 'sendgrid-ruby'
include SendGrid 

module SendMail
    class SendMail
        include ::Hanami::Action
        def call (env) 
            response = request.body.read
            self.body = response
            emailDetails = JSON.parse(response)
            puts emailDetails
            email = emailDetails['emailDetails']['email']

            begin
                con = PG.connect :host => 'ec2-3-234-22-132.compute-1.amazonaws.com', :dbname => 'd1re1k2rplt7t2', :user => 'sewuvljklsqoqu', :password => '18f0134f286951799b72989aaf762d0ef926afad65d2c9e6f7c959aa991b1246'

                existingUser = con.exec "select exists (select * from emp where email='#{email}')"
                puts existingUser[0]["exists"]

                if existingUser[0]["exists"]=='t'
                    from = SendGrid::Email.new(email: 'emsappyvrk@gmail.com')
                    to = SendGrid::Email.new(email: email)
                    subject = 'Password Reset Code'
                    content = SendGrid::Content.new(type: 'text/html', value: 'The Password Reset Code is 123')
                    mail = SendGrid::Mail.new(from, subject, to, content)

                    sg = SendGrid::API.new(api_key: 'NRTmxilQds3jquVipRjV9YgmMmg4F_jJgtyD1Xm0')
                    response = sg.client.mail._('send').post(request_body: mail.to_json)

                    puts response.status_code
                    puts response.body
                    puts response.headers
                    

                        result = "Mail Sent"
                        response = {'result' => result}
                        
                        puts response
                        res = JSON.generate(response)

                        self.body = res
                else 
                    result = "Not Existing User"
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

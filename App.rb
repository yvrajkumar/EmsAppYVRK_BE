require 'hanami/router'
 
class App
  def self.router
    Hanami::Router.new do
      get '/',        to: CreateTable::CreateTable
      post '/SignIn',   to: ->(env) { [200, {}, [request.body.read]] }
      post '/SignUp', to: AddEmp::AddEmp
      post '/UpdateProfile', to: UpdateProfile::UpdateProfile
      post '/DeleteProfile', to: DeleteProfile::DeleteProfile
      post '/SendMail', to: SendMail::SendMail
    end
  end
end

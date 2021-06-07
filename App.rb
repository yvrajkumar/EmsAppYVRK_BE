require 'hanami/router'
 
class App
  def self.router
    Hanami::Router.new do
      get '/',        to: CreateTable::CreateTable
      post '/SignIn',   to: SignIn::SignIn
      post '/SignUp', to: ->(env) { [200, {}, [request.body.read]] }
      post '/UpdateProfile', to: UpdateProfile::UpdateProfile
      post '/DeleteProfile', to: DeleteProfile::DeleteProfile
      post '/SendMail', to: SendMail::SendMail
    end
  end
end

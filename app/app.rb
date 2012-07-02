
require 'pry'

class App < Sinatra::Base

  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :academiaedu,
      'b944c3929026621a94ac615ce11e9c8c355ce9c6161e0d6a77a2e194d717cabc',
      'a8d6b5f5705a9fb38b92c67b6a22cd1291449a6a818630096003401b8b546992'
  end

  helpers do
    def current_user
      @current_user ||= if session['uid']
        session['info']
      end
    end
  end

  get '/' do
    slim :index
  end

  get '/auth/:name/callback' do
    auth = request.env['omniauth.auth']
    session['uid'] = auth['uid']
    session['info'] = auth.info.to_hash
    redirect '/'
  end

end

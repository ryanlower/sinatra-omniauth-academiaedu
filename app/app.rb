
class App < Sinatra::Base

  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :academiaedu,
      ENV['AUTH_KEY'],
      ENV['AUTH_SECRET']
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

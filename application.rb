class MyApp < Sinatra::Base
    
  DB = Sequel.sqlite

  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack
  
  PUSHER_KEY = ENV["PUSHER_KEY"]
  PUSHER_SECRET = ENV["PUSHER_SECRET"]
  
  enable  :sessions
  
  assets {
    serve '/js',     from: 'app/js'        # Optional
    serve '/css',    from: 'app/css'       # Optional
    serve '/images', from: 'app/images'    # Optional
    
    js :app, '/js/app.js', [
      '/jst.js',
      '/js/**/*.js'
    ]
  
    css :application, '/css/application.css', [
      '/css/screen.css'
    ]
  
    js_compression  :jsmin      # Optional
    css_compression :sass       # Optional
  }
  
  register Sinatra::JstPages
  serve_jst '/jst.js'
  
  get '/' do
    @identity = session[:identity]
    @key = PUSHER_KEY
    @sec = PUSHER_SECRET
    erb :index
  end
  
  get '/room/create' do
    
  end
    
  post '/join' do
    session[:identity] = {
      :name => params[:display_name],
      :avatar => "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(params[:email])}"
    }
    redirect request.referer
  end
end

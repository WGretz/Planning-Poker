
class MyApp < Sinatra::Base

  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end

  require './models/room.rb'

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
    
  post '/join' do
    session[:identity] = {
      :name => params[:display_name],
      :avatar => "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(params[:email])}"
    }
    redirect request.referer
  end
  
  get_or_post '/room/show' do
    if params[:room_name]
      session[:room_name] = params[:room_name]
    else
      params[:room_name] = session[:room_name]
    end
    if params[:room_name].nil?
      redirect "/"
      return
    end
    @room_name = params[:room_name]
    @room = Room.find(params[:room_name])
    @room.inspect
    @identity = session[:identity]
    erb :room_show
  end
  
  post '/pusher/auth' do
    puts params.inspect
  end
  
end

class MyApp < Sinatra::Base
    
      set :root, File.dirname(__FILE__)
      register Sinatra::AssetPack
      
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
        erb :index
      end
  
end

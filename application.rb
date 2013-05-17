# encoding: UTF-8
# Libraries::::::::::::::::::::::::::::::::::::::::::::::::::::::::
require 'sinatra/base'
require 'sinatra/flash'
require 'rack/csrf'
require 'sprockets'
require 'haml'
require 'sass'
require 'coffee-script'
require 'padrino-helpers'
require 'sinatra/partial'
require './app/helpers/app_helpers'
require 'itout'

# Application::::::::::::::::::::::::::::::::::::::::::::::::::::::
class Application < Sinatra::Base

  include Sinatra::AssetHelpers

  register Sinatra::Flash
  register Padrino::Helpers
  register Sinatra::Partial
  register ITout
  
  client_id = "80c5a655ad20e8819dc0cf580e5828cb5474cd5692c8b39acd5ea8410756cdde"
  client_secret = "5ca12cb9a77f1d1c5ad0e8c6369d910a12862b2a8a138eaa152fcac931c8842c"
  callback_url = "http://localhost/login"
  
  client = ITout.client(client_id, client_secret, callback_url, email:"tout@tout-dev.me", password:"139townsend")  
  client.client_auth()

  # Config::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  set :port, 80
  set :partial_template_engine, :haml
  enable :partial_underscores
  set :static, true
  set :root, File.dirname(__FILE__)
  set :sprockets, (Sprockets::Environment.new(root) { |env| env.logger = Logger.new(STDOUT) })
  set :assets_prefix, 'compiled'
  set :assets_path, File.join(root, 'public', assets_prefix)
  set :views, Proc.new { File.join(root, 'app', 'views') }
  
  configure do
    sprockets.append_path File.join(root, 'app', 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'app', 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'app', 'assets', 'images')
  end


  # we are deploying to heroku, which does not have a JVM, which YUI needs, so let's
  # only require and config the compressors / minifiers for dev env
  configure :development do
    require 'yui/compressor'
    require 'uglifier'
    sprockets.css_compressor = YUI::CssCompressor.new
    sprockets.js_compressor  = Uglifier.new(mangle: true)
  end

  # Calculate time between current time and the tout time in either minutes, seconds, hours or days.
  
  def tout_time(tout)
    current_time = Time.now.utc
    tout = Time.parse(tout)
    seconds = (current_time - tout).to_i
    if seconds >= 60
      minutes = seconds / 60
      if minutes >= 60
        hours = minutes / 60
        if hours >= 24
          days = hours / 24
          return days.to_s + " days"
        else
          return hours.to_s + " hours"
        end
      else
        return minutes.to_s + " mins"
      end
    else
      return seconds.to_s + " seconds"
    end
  end

  # Route Handlers::::::::::::::::::::::::::::::::::::::::::::::::
  # index
  get '/' do 
    featured_touts = client.featured_touts({:per_page => 10, :page => 1})
    @touts = featured_touts.sort_by(&:created_at).reverse 
    haml :index, layout:false     
  end

  # account
  get '/my-profile' do
    featured_touts = client.featured_touts({:per_page => 10, :page => 1})
    @touts = featured_touts.sort_by(&:created_at).reverse
    haml :'users/_my_profile', layout:false
  end

  get '/users-profile/:username' do
    user_touts = client.retrieve_user_touts(params[:username], "most_recent_first", 10, 1)
    @touts = user_touts.sort_by(&:created_at).reverse
    user = client.retrieve_user(params[:username])
    @fullname = user["fullname"]
    @bio = user["bio"]
    @followers_count = user["followers_count"]
    @friends_count = user["friends_count"]
    @touts_count = user["touts_count"]
    @avatar = user["avatar"]["small"]["http_url"]
    @username = user["username"]
    @followers = client.retrieve_user_followers(params[:username])
    @following = client.retrieve_user_following(params[:username])
    haml :'users/_users_profile'
  end

  # assets
  get '/assets/jquery.mobile-1.2.0.min.js' do
    content_type('application/javascript')
    settings.sprockets['jquery.mobile.js']
  end

  get '/assets/jquery-1.8.3.min.js' do
    content_type('application/javascript')
    settings.sprockets['jquery.js']
  end
 
  get '/assets/application.js' do
    content_type('application/javascript')
    settings.sprockets['application.js']
  end

  get '/assets/masonry.js' do
    content_type('application/javascript')
    settings.sprockets['masonry.js']
  end

  get '/assets/application.css' do
    content_type('text/css')
    settings.sprockets['application.css']
  end

  %w{jpg jpeg gif png}.each do |format|
    get '/assets/:image.' + format do |image|
      content_type('image/' + format)
      settings.sprockets[image + '.' + format]
    end
  end

end


__END__




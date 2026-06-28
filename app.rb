require 'sinatra'
require 'mongoid'
require 'json'
require 'dotenv/load'

Mongoid.load!("config/mongoid.yml", :production)

enable :sessions
enable :method_override  


require_relative 'db/post'
require_relative 'helper/auth_helpers'
require_relative 'Controller/posts_controller'
require_relative 'Controller/admin_controller'

set :public_folder, 'public'

helpers AuthHelper

use AdminController
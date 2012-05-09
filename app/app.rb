require 'garry'
require 'padrino/sprockets'
require "stripe"
Stripe.api_key = ENV['STRIPE_KEY']           
   
class SimpleShopDemoGarry < Padrino::Application  
  use Airbrake::Rack     
  register Padrino::CSRF  
  register Padrino::Rendering
  register Padrino::Helpers   
  register Padrino::Admin::AccessControl 
  register CompassInitializer
  register PadrinoFields
  set :default_builder, 'PadrinoFieldsBuilder'

  enable :sessions        
  disable :prevent_request_forgery            
  
  set :stylesheets_folder, :css
  set :javascripts_folder, :js
  register Padrino::AssetHelpers
  register Padrino::Sprockets   
  register Padrino::Responders    
  
  ## 
  # Assets
  #
  
  assets do    
    digest false  
    handle_stylesheets false  
    assets_folder '/public'
    append_path 'assets/js'  
    append_path '../lib/assets/js'
    append_path '../vendor/assets/js'   
  end  
  
  access_control.roles_for :any do |role|
    role.protect "/stripe-checkout"  
  end

  access_control.roles_for :registered do |role|
    role.allow "/stripe-checkout"
  end
end
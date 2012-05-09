require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Categories Controller" do  
  setup do  
    header 'Accept', 'text/html'     
  end     
  
  should "return a checkout page" do    
    get '/checkout'
    assert last_response.status == 200
  end  
      
  # TODO
  # should "checkout a cart and redirect" do  
  #   post '/stripe_checkout', params[:]
  #   assert last_response.status == 302
  # end            
end
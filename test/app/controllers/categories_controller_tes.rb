require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Categories Controller" do  
  context "ajax" do   
    setup do    
      header 'Accept', 'application/json'
    end    
    
    should 'paginate categories' do       
      get '/categories/page/1', {}, :xhr => true      
      assert last_response.status == 200   
      
      cats = JSON.parse(last_response.body)      
      assert !cats[0]['slug'].blank?    
      assert cats.length > 1 
    end
  end  
  
  context "normal" do 
    setup do     
      header 'Accept', 'text/html'     
    end       
    
    should 'return index' do    
      get '/categories/page/1'
      assert last_response.status == 200
    end
  end         
end
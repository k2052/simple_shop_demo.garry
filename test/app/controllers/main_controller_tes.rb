require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Main Controller" do  
  context "ajax" do   
    setup do    
      header 'Accept', 'application/json'
    end   
    
    should 'return categories' do       
      get '/', {}, :xhr => true      
      assert last_response.status == 200   
      
      cats = JSON.parse(last_response.body)      
      assert !cats[0]['slug'].blank?
    end
  end
  context "normal" do 
    setup do     
      header 'Accept', 'text/html'     
    end       
    
    should 'return index' do    
      get '/'
      assert last_response.status == 200
    end
  end         
end
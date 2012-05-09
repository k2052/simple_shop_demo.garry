require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Products Controller" do  
  setup do     
    @account = Account.first()       
    
    post '/sessions/create', {:email => @account.email, :password =>'testpass'}  
    assert last_response.status == 302
  end
  
  context "ajax" do  
    setup do    
      header 'Accept', 'application/json'
    end
     
    should "return a product page" do  
      p = Product.first
      
      get "/products/#{p.slug}", {}, :xhr => true
      assert last_response.status == 200
      
      product = JSON.parse(last_response.body)['data']['product']    
      assert_equal product['slug'], p.slug
      assert_equal product['title'], p.title
    end

    should "return products by category" do        
      cat = Category.first
      
      get "/category/#{cat.slug}" 
      assert last_response.status == 200
      
      products = JSON.parse(last_response.body)      
      assert !products[0]['slug'].blank?     
      assert products.length > 1
    end
  end             
  
  context "normal" do 
    setup do     
      header 'Accept', 'text/html'     
    end     
    
    should "return a product page" do   
      p = Product.first 
      
      get "/products/#{p.slug}"
      assert last_response.status == 200
    end
    
    should "return products by category" do 
      cat = Category.first
      
      get "/category/#{cat.slug}" 
      assert last_response.status == 200 
    end
  end      
  
  context "ajax and normal" do 
    setup do     
      header 'Accept', 'text/html'   
        
      @account = Account.first(:cart_id => nil)       

      post '/sessions/create', {:email => @account.email, :password =>'testpass'}  
      assert last_response.status == 302 
    end
         
    should "add a product to cart" do     
      cart = @account.cart
      
      p = Product.first(:_id.ne => cart.item_ids)         
      
      get "/products/#{p.slug}"
      assert last_response.status == 200
      
      get "/products/add-to-cart/#{p.slug}"
      assert last_response.status == 302
      
      follow_redirect!
      
      assert_equal "http://example.org/products/#{p.slug}", last_request.url 
         
      cart = @account.cart
      assert cart.items.count > 0  
      assert cart.items_full.count > 0
    end

    should "remove a product from cart" do 
      cart = @account.cart
      
      p = Product.first(:_id.ne => cart.item_ids)     
            
      get "/products/#{p.slug}"
      assert last_response.status == 200      
      cart.add(p)    
      cart.save
      
      cart = Cart.find_by_id?(cart.id)      
      assert cart.item_in_cart?(p.id) == true
      
      get "/products/remove-from-cart/#{p.slug}"
      assert last_response.status == 302
      
      follow_redirect!
      
      assert_equal "http://example.org/products/#{p.slug}", last_request.url       
      
      cart = Cart.find_by_id?(cart.id)      
      assert cart.item_in_cart?(p.id) == false
    end
  end 
end
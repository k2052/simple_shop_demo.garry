SimpleShopDemoGarry.controllers :products do        
  before do
    @options = {:order => 'updated_at desc'}
  end
  
  before do    
    if params[:page]     
      @pagenum = params[:page].to_i
      halt 403, "Malformed Pagenum" if !@pagenum.is_a?(Numeric)         
    end  
  end
  
  before(:by_cat) do 
    @category = Category.find_by_slug(params[:category])
  end 

  before do    
    @pager = Paginator.new(Product.count, 25) do |offset, per_page|
      @options[:skip]  = offset 
      @options[:limit] = per_page  
      @options[:category_id] = @category.id if @category
      Product.all(@options)  
    end
    @products = @pager.page(@pagenum)
  end  
  
  before(:add_to_cart, :remove_from_cart) do       
    @cart    = current_cart()
    @product = Product.find_by_slug(params[:slug])
  end

  get :add_to_cart, :map => "/products/add-to-cart/:slug" do   
    @cart.add(@product)   
    if @cart.save  
      redirect_back_or_default(url_for(:products, :show, :slug => @product.slug))         
    else  
      error_resp(@cart, "Failed to add the product")     
      redirect_back_or_default(url_for(:products, :show, :slug => @product.slug))         
    end
  end     
  
  get :remove_from_cart, :map => "/products/remove-from-cart/:slug" do   
    @cart.remove(@product)   
    if @cart.save  
      redirect_back_or_default(url_for(:products, :show, :slug => @product.slug))         
    else  
      error_resp(@cart, "Failed to remove the product from cart")     
      redirect_back_or_default(url_for(:products, :show, :slug => @product.slug))         
    end
  end
  
  get :by_cat, :map => "/category/:category/(page/:page)" do           
    respond(@products) 
  end      

  get :show, :map => "/products/:slug" do      
    @product = Product.find_by_slug(params[:slug])   
    respond(@product)
  end  
end
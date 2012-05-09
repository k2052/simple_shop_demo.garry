SimpleShopDemoGarry.controllers :categories do    
  before do
    @options = {:order => 'updated_at desc'}
  end
  
  before do    
    if params[:page]     
      @pagenum = params[:page].to_i
      halt 403, "Malformed Pagenum" if !@pagenum.is_a?(Numeric)         
    end  
  end
  
  before do    
    @pager = Paginator.new(Category.count, 5) do |offset, per_page|
      @options[:skip]  = offset 
      @options[:limit] = per_page
      Category.all(@options)  
    end
    @categories = @pager.page(@pagenum)
  end
  
  get :index, :map => "/categories/page/(:page)" do   
    respond(@categories) 
  end  
end        
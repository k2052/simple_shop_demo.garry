SimpleShopDemoGarry.controllers :main do              
  get :index, :map => '/' do 
    @categories = Category.all   
    respond(@categories)
  end 
end
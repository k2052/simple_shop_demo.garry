SimpleShopDemoGarry.controllers :cart do       
  before do
    @cart    = current_cart   
    @account = current_account     
    @account = Account.new() unless @account
  end  
  
  get :checkout, :map => "/checkout" do     
    @items = @cart.items_full
    render "cart/checkout"
  end  
  
  post :stripe_checkout, :map => "/stripe-checkout" do   
    current_account.stripe_update({:card => params[:stripe_token]})        
    @cart.checkout                
    flash[:notice] = "You've been checked out. Once your payment is processed we'll send you an email."
    redirect_to('/')
  end   
end
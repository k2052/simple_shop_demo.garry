SimpleShopDemoGarry.controllers :sessions do   
  get :new, :map => '/login' do 
    render 'sessions/new'
  end        
  
  post :create, :map => '/login' do
    if @account = Account.authenticate(params[:email], params[:password])
      set_current_account(@account)  
      success_resp(@account, "Logging you in") 
      redirect_back_or_default('/') 
    else     
      error_resp(@account, "E-mail or password wrong.")  
      redirect_back_or_default('/') 
    end      
  end  
  
  delete :destroy, :map => '/logout' do
    set_current_account(nil)
    redirect_back_or_default(url(:sessions, :new))
  end   
  
  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect_back_or_default(url(:sessions, :new))
  end
end
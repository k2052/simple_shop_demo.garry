SimpleShopDemoGarry.controllers :accounts, :provides => [:json, :html] do    
  before(:edit, :update, :destroy) do  
    @account = current_account   
    halt 403, 'Login first' unless @account
  end
  
  get :new do
    @account = Account.new
    respond(@account)
  end

  post :create, :map => '/accounts/new' do    
    halt 400, 'Role' if params[:account][:role]
     
    if current_account  
      flash[:notice] = "You are already registered"  
      redirect_back_or_default(url(:main, :index))
    end 
        
    @account = Account.new(params[:account])   
    @account.save              
    respond(@account, url(:main, :index))
  end  

  get :edit do
    respond(@account)
  end

  put :update, :protect => true do      
    @account.update_attributes(params[:account])  
    respond(@account, url(:accounts, :edit))
  end      

  delete :destroy do
    @account.destroy
    respond(@account, url(:main, :index)) 
  end       
end
##
# Make sure to uncomment this and seed DB with an admin account. Or add it manually using console.

# email     = shell.ask "Which email do you want use for logging into admin?"
# password  = shell.ask "Tell me the password to use:"
# 
# shell.say ""
# 
# account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")
# 
# if account.valid?
#   shell.say "================================================================="
#   shell.say "Account has been successfully created, now you can login with:"
#   shell.say "================================================================="
#   shell.say "   email: #{email}"
#   shell.say "   password: #{password}"
#   shell.say "================================================================="
# else
#   shell.say "Sorry but some thing went wrong!"
#   shell.say ""
#   account.errors.full_messages.each { |m| shell.say "   - #{m}" }
# end
# 
# shell.say ""  
          
shell.say "Creating some accounts. 5 to be exact"

5.times do |i|    
  account = Account.new(:email => Faker::Internet.email, :username => Faker::Internet.user_name, :name => Faker::Name.name, :password => 'testpass', 
    :password_confirmation => 'testpass')    
  account.save 
       
  account = Account.find_by_id(account.id)  
  card = {
    :number    => 4242424242424242,
    :exp_month => 8,
    :exp_year  => 2013
  } 
  account.update_stripe(:card => card)
end

shell.say "Creating some categories and products"   

8.times do |i|       
  cat = Category.new(:title => Faker::Name.name, :desc => Faker::Lorem.paragraphs(2).join(" "))  
  cat.image = File.open(File.expand_path(File.dirname(__FILE__) + '/../test/data/CategoryImage.jpg'))
  cat.save
    
  5.times do |t|  
    product = Product.new(:title => Faker::Name.name, :desc => Faker::Lorem.paragraphs(2).join(" "), :price => 5005,
      :category_id => cat.id)
    product.image = File.open(File.expand_path(File.dirname(__FILE__) + '/../test/data/ProductImage.jpg'))
    product.save  
  end
end
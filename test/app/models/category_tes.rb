require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
  
describe "Category Model" do        
  setup do  
  end       
  
  should "create a new category model instance" do      
    cat = Category.new(:title => Faker::Name.name, :desc => Faker::Lorem.paragraphs(2).join(" "))  
    cat.save
    assert cat.errors.size == 0
  end                
  
  should "add an image to a cat" do   
    cat       = Category.new(:title => Faker::Name.name, :desc => Faker::Lorem.paragraphs(2).join(" "))   
    cat.image = File.open(File.expand_path(File.dirname(__FILE__) + '/../../data/CategoryImage.jpg'))
    cat.save
    assert cat.errors.size == 0
  end
end
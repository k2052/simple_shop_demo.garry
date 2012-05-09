class Category
  include MongoMapper::Document       
  include MongoMapperExt::Slugizer
  
  key :title, Text
  key :desc,  String 
  
  mount_uploader :image, ImageUploader   
  
  has_many :products     
  
  slug_key :title, :unique => true      
end
class Product
  include MongoMapper::Document 
  include Garry::Purchasable
       
  key :desc,          String 
  key :category_id,   ObjectId        
  key :short_desc,    String
  mount_uploader :image, ImageUploader    
  
  before_save :gen_short_desc      
  
  def gen_short_desc()       
    self[:short_desc] = self[:desc].truncate(144) if self[:desc]
  end   
end
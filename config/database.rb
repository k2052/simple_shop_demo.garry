MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'simple_shop_demo_garry_development'
  when :production  then MongoMapper.database = 'simple_shop_demo_garry_production'
  when :test        then MongoMapper.database = 'simple_shop_demo_garry_test'
end

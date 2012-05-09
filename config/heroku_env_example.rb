# Stripe 
if Padrino.env == :development or  Padrino.env == :test  
  ENV['STRIPE_KEY']     = 'zxzxx'
  ENV['STRIPE_PUB_KEY'] = 'zxzxzxxz'       
end

ENV['STRIPE_KEY']     = 'xxxxx' if Padrino.env == :production
ENV['STRIPE_PUB_KEY'] = 'xxxxx' if Padrino.env == :production  

ENV["AIRBRAKE_API_KEY"] = "xzxxz"

# S3
ENV['S3_ACCESS_KEY']        = 'X'
ENV['S3_SECRET_ACCESS_KEY'] = 'XXXXXXXXXXXXXX'
ENV['S3_BUCKET']            = 'media.example.com'
# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6LcUVwwUAAAAABB8RNVbxtWDo3ZtrwsT16yz1Hi9'
  config.secret_key = '6LcUVwwUAAAAAM3oYbRIVMrsIzgJ5RK3QrKBgk7E'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end

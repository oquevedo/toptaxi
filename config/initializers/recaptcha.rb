#DEFAULTINIT Add keys corresponding to app
Recaptcha.configure do |config|
  config.public_key  = '6LcEgwgTAAAAAKMVxOZCGfTt2Xp2_mnYmnW7DY65'
  config.private_key = '6LcEgwgTAAAAAPY7rTq2S9nIzT2thzH8vKxKYF5s'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
  # Uncomment if you want to use the newer version of the API,
  # only works for versions >= 0.3.7:
  # config.api_version = 'v2'
end
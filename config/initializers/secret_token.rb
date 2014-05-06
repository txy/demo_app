# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file,token) 
    token
  end
end

DemoApp::Application.config.secret_key_base = secure_token
DemoApp::Application.config.secret_token = 'f54f217f94120ee12b36164ccc38acf74969cb508967d7b3c010e6f0e395b5766e37ee2928257576c1dd93d9768735849184cf263d987f5543bdd1f0eaa15b17'

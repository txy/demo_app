source 'https://rubygems.org'
#source 'http://rubygems.org'
#source 'http://gems.github.com'

gem 'rails', '3.2.3'
gem 'bootstrap-sass' ,'3.1.1'
gem 'bcrypt'   
gem 'bcrypt-ruby'  ,'3.1.5'
#哈希函数bcrypt对密码加密
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development, :test do
  gem 'sqlite3' 
  #gem 'pg', '0.15.1'
  gem 'rspec-rails', '2.13.1'
  gem 'guard-rspec', '3.1.0' 

  gem 'spork-rails' ,'4.0.0'
  gem 'guard-spork'  
  gem 'childprocess'  

end

group :test do
  gem 'selenium-webdriver' , '2.35.1' 
  gem 'capybara', '2.1.0'
end
 

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.3'
  gem 'coffee-rails', '3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '1.0.3'
end
 
gem 'jquery-rails' ,'2.2.1'

gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor' ,'0.0.2'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

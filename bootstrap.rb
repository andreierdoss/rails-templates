source_paths << File.dirname(__FILE__)

run 'cat /dev/null > Gemfile'
add_source "https://rubygems.org"

inject_into_file 'Gemfile', after: 'source "https://rubygems.org"' do
  "\nruby File.read '.ruby-version'\n"
end
file '.ruby-version', '2.1.1'

gem 'rails', '4.1.4'
gem 'thin', '~> 1.6.2'
gem 'pg', '~> 0.17.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'bootstrap-sass', '~> 3.2.0.0'
gem 'autoprefixer-rails', '~> 2.1.1.20140710'
gem 'simple_form', '~> 3.0.2'
gem 'awesome_print', '~> 1.2.0'
gem 'rails_12factor', '~> 0.0.2', group: :production

gem_group :development, :test do
  gem 'pry-debugger', '~> 0.2.3'
  gem 'rspec-rails', '~> 3.0.2'
end

gem_group :development do
  gem 'spring', '~> 1.1.3'
  gem 'spring-commands-rspec', '~> 1.0.2'
end

gem_group :test do
  gem 'minitest', '~> 5.4.0'
  gem 'shoulda-matchers', '~> 2.6.2'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'capybara-webkit', '~> 1.2.0'
  gem 'selenium-webdriver', '~> 2.42.0'
  # gem 'capybara-email', '~> 2.4.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'launchy', '~> 2.4.2'
  gem 'json_spec', '~> 1.1.2'
end

run 'rm app/views/layouts/application.html.erb'
run 'rm app/assets/stylesheets/application.css'
run 'rm app/assets/javascripts/application.js'
run 'rm README.rdoc'

generate 'simple_form:install --bootstrap'
generate 'rspec:install'

copy_file 'bootstrap/application.html.haml', 'app/views/layouts/application.html.haml'
copy_file 'bootstrap/application.css.scss', 'app/assets/stylesheets/application.css.scss'
copy_file 'bootstrap/application.js', 'app/assets/javascripts/application.js'
copy_file 'bootstrap/capybara_helper.rb', 'spec/support/capybara_helper.rb'
copy_file 'bootstrap/database_cleaner_helper.rb', 'spec/support/database_cleaner_helper.rb'
copy_file 'bootstrap/deferred_gc.rb', 'spec/support/deferred_gc.rb'
run 'rm spec/rails_helper.rb'
copy_file 'bootstrap/rails_helper.rb', 'spec/rails_helper.rb'
file 'spec/factories.rb', ''

if yes? 'Is postgres running?'
 rake 'db:create db:migrate'
end

route 'root to: "application#show"'

# Git
git :init
git add: "."
git commit: "-a -m 'Application bootstraped'"

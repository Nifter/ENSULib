task :sample_data => :environment do
  require 'faker'  
end

namespace :db do # put under the 'rake db:something' heading 
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke # runs rake db:reset
    admin = User.create!(:name => "Test User",
                         :email => "test3@example.com",
                         :password => "password",
                         :password_confirmation => "password")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example_#{n+1}@example.com"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    
    User.all(:limit => 6).each do |user|
      50.times do
        user.books.create!(:title => Faker::Lorem.words(1),
                           :author => Faker::Lorem.words(1),
                           :call_number => Faker::Lorem.words(1),
                           :publication_year => (2000 + user.id), 
                           :borrowed_at => Time.now)
      end
    end
  end
  
end
require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example User",
                 :email => "example@rira.app",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@rira.com"
      password = "password"
      User.create!(:name => name,
      :email => email,
      :password => password,
      :password_confirmation => password)
    end

    User.all.each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5) , :msisdn_id => 1 )
        end
    end

  end
end
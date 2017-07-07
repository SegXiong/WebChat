namespace :dev do
  task :fake_user => :environment do
    users = []
    20.times do |i|
      users << User.create!(:email => Faker::Internet.email, :user_name => Faker::Cat.name, :password => "123456", :password_confirmation => "123456")
      puts "Created User #{i}"
    end
  end
end

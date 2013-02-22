# By using the symbol ':user', we get Factory Girl to simulate the User model.

FactoryGirl.define do
  factory :user do
    name       "Omid"
    email      "omid@rira.app"
    password   "omid123"
    password_confirmation "omid123"
    roles []
    microposts []
    #right = Right.new( :controller => 'microposts', :action => 'create' )
    #role = Role.new( :name => 'radmin' )
    #role.rights = [ right ]
    #roles  [ role ]
  end

  factory :micropost do
    association :user
    content "Foo bar"
  end

  factory :role do
    #association :user
    name 'radmin'
  end

  factory :right do
    association :role
    controller 'microposts'
    action 'create'
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end
end



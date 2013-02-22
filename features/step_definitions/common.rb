def signin_for_user( email )
  visit( '/signin' )
  fill_in( "User Name", :with => email )
  fill_in( "Password", :with => email + "-test-passwd" )
  click_button( "Sign In" )
end

def current_path
  URI.parse(current_url).path
end


Given /^a user "([^"]*)" exists$/ do |user|
  @user = FactoryGirl.create(:user)
end

Given /^"(.*?)" is not signed\-in$/ do |user|
  #pending # express the regexp above with the code you wish you had
  visit "/signout"
end

When /^"(.*?)" visit (.*?)$/ do |user, page|
  #pending # express the regexp above with the code you wish you had
  visit path_to( page )
end

Then /^"(.*?)" must be redirected to (.*?)$/ do |user, page|
  #pending # express the regexp above with the code you wish you had
  current_path.should == path_to( page )
end

Given /^"(.*?)" is signed\-in$/ do |user|
  #pending # express the regexp above with the code you wish you had
  visit "/signin"
  fill_in "session_email", :with => "user"
  fill_in "session_password", :with => "user"
  click_button "Sign in"
end

Given /^"(.*?)" does not have the (.*?) role$/ do |user, role|
  pending # express the regexp above with the code you wish you had
  #current_user.
end

Then /^"(.*?)" should see error "(.*?)"$/ do |user, error|
  pending # express the regexp above with the code you wish you had
end

Given /^"(.*?)" has the (.*?) role$/ do |user, role|
  pending # express the regexp above with the code you wish you had
end

When /^type tree id as "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^click on "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^enter user\/pass as "(.*?)" and "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /statement identifier( not)? expectation "([^\"]+)"/i do |boolean, value|
  actual = expectation( value )
  expected = !boolean
  message = "expectation failed for #{value}"
  assert( actual == expected, message )
end

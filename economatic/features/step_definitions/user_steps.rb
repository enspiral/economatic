def users
  @users ||= {}
end

Given /^a user ([^ ]*)$/ do |user_name|
  @users ||= {}
  @users[user_name] = @user = Economatic::User.create(name: user_name)
end


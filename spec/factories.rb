Factory.define :user do |user|
  user.name                  "FirstName LastName"
  user.email                 "test@example.com"
  user.password              "password"
  user.password_confirmation "password"
end

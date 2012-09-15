Factory.define :user do |user|
  user.name                  "FirstName LastName"
  user.email                 "test@example.com"
  user.password              "password"
  user.password_confirmation "password"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :book do |book|
  book.title "Book Name"
  book.author "Some Author"
  book.publication_year 1990
end

Factory.define :borrowed_book, :parent => :user do |book|
  book.after_create { |a| Factory(:book, :user => a) }
end

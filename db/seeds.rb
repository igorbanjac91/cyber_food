
3.times do |n|
  User.create(
    first_name: "name-#{n}",
    last_name: "last_name-#{n}",
    email: "user-#{n}@gmail.com",
    password: "password",
    password_confirmation: "password"
  )
end

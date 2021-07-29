User.create(
  first_name: "admin",
  last_name: "admin",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)
User.create(
  first_name: "John",
  last_name: "Smith",
  email: "user@gmail.com",
  password: "password",
  password_confirmation: "password"
)

3.times do |n|
  User.create(
    first_name: "name-#{n}",
    last_name: "last_name-#{n}",
    email: "user-#{n}@gmail.com",
    password: "password",
    password_confirmation: "password"
  )
end

pizza_category = Category.create(name: "pizza")
pizza_category.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/pizzas.jpg'), filename: 'pizzas.jpg')
pasta_category = Category.create(name: "pasta")
pasta_category.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/pastas.jpg'), filename: 'pastas.jpg')
mains_category = Category.create(name: "mains")
mains_category.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/main.jpg'), filename: 'main.jpg')
antipasti_category = Category.create(name: "antipasti")
antipasti_category.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/antipasti.jpg'), filename: 'antipasti.jpg')
drinks_category = Category.create(name: "drinks")
drinks_category.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/drinks.jpg'), filename: 'drinks.jpg')


plank = FoodItem.create(name: "Seasonal Vegetables Plank", 
                description: "Marinated & grilled pepper, courgette & aubergine with baby mozzarella, focaccia, grissini, olives & pickles",
                category: antipasti_category,
                price: 7.00)
plank.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/plank.jpg'), filename: 'plank.jpg')
                
pizza_julietta = FoodItem.create(name: "Julietta",
                description: "Slow-roasted tomatoes, basil, the best buffalo mozzarella & aged Parmesan", 
                category: pizza_category,
                price: 12.80)
pizza_julietta.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/pizza-julietta.jpg'), filename: 'pizza-julietta.jpg')

pork = FoodItem.create(name: "Pork Chop Panzanella",
                description: "With smashed ricotta & feta, cherry tomato panzanella salad & fresh oregano, served with spiced fries", 
                category: mains_category,
                price: 13.80)      
pork.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/pork-chop.jpg'), filename: 'pork-chop.jpg')                

penne_pomodoro = FoodItem.create(name: "Penne Pomodoro",
                description: "Sweet tomato sauce, garlic, basil, mascarpone, mozzarella,Italian hard cheese & herby breadcrumbs", 
                category: pasta_category,
                price: 12.20)               
penne_pomodoro.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/penne-pomodoro.jpg'), filename: 'penne-pomodoro.jpg')

coco_cola = FoodItem.create(name: "Coca Cola",
                description: "Origianal Coca Cola", 
                category: drinks_category,
                price: 2.50)                
coco_cola.image.attach(io: File.open('/home/igor/portfolio/rails-projects/cyber_food/storage/local/coca-cola.jpg'), filename: 'coca-cola.jpg')
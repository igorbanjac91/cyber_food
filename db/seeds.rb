User.find_or_create_by(
  first_name: "admin",
  last_name: "admin",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)

User.find_or_create_by(
  first_name: "John",
  last_name: "Smith",
  email: "user@gmail.com",
  password: "password",
  password_confirmation: "password"
)

3.times do |n|
  User.find_or_create_by(
    first_name: "name-#{n}",
    last_name: "last_name-#{n}",
    email: "user-#{n}@gmail.com",
    password: "password",
    password_confirmation: "password"
  )
end

# Create Categories

pizza_category = Category.find_or_create_by(name: "pizza")
pasta_category = Category.find_or_create_by(name: "pasta")
mains_category = Category.find_or_create_by(name: "mains")
antipasti_category = Category.find_or_create_by(name: "antipasti")
drinks_category = Category.find_or_create_by(name: "drinks")

# Create Food Items

penne_pomodoro = FoodItem.find_or_create_by(name: "Penne Pomodoro",
                description: "Sweet tomato sauce, garlic, basil, mascarpone, mozzarella,Italian hard cheese & herby breadcrumbs", 
                category: pasta_category,
                price: 1220)               

pizza_julietta = FoodItem.find_or_create_by(name: "Julietta",
                description: "Slow-roasted tomatoes, basil, the best buffalo mozzarella & aged Parmesan", 
                category: pizza_category,
                price: 1280)

plank = FoodItem.find_or_create_by(name: "Seasonal Vegetables Plank", 
                description: "Marinated & grilled pepper, courgette & aubergine with baby mozzarella, focaccia, grissini, olives & pickles",
                category: antipasti_category,
                price: 700)
                

pork = FoodItem.find_or_create_by(name: "Pork Chop Panzanella",
                description: "With smashed ricotta & feta, cherry tomato panzanella salad & fresh oregano, served with spiced fries", 
                category: mains_category,
                price: 1380)      


coca_cola = FoodItem.find_or_create_by(name: "Coca Cola",
                description: "Origianal Coca Cola", 
                category: drinks_category,
                price: 250)               


# Attach images 

attach_image(pizza_category, 'app/assets/images/database_seed/pizzas.jpg', 'pizzas.jpg')
attach_image(pasta_category, 'app/assets/images/database_seed/pastas.jpg', 'pastas.jpg')
attach_image(mains_category, 'app/assets/images/database_seed/main', 'main.jpg')
attach_image(drinks_category, 'app/assets/images/database_seed/drinks.jpg', 'drinks.jpg')

attach_image(penne_pomodoro, 'app/assets/images/database_seed/penne-pomodoro.jpg', 'penne-pomodoro.jpg')
attach_image(pizza_julietta, 'app/assets/images/database_seed/pizza-julietta.jpg', 'pizza-julietta.jpg')
attach_image(plank, 'app/assets/images/database_seed/plank.jpg', 'plank.jpg')
attach_image(pork, 'app/assets/images/database_seed/pork-chop.jpg', 'pork-chop.jpg')
attach_image(coco_cola, 'app/assets/images/database_seed/coca-cola.jpg', 'coca-cola.jpg')



# pizza_category.image.attach(io: File.open('app/assets/images/database_seed/pizzas.jpg'), filename: 'pizzas.jpg')
# pasta_category.image.attach(io: File.open('app/assets/images/database_seed/pastas.jpg'), filename: 'pastas.jpg')
# mains_category.image.attach(io: File.open('app/assets/images/database_seed/main.jpg'), filename: 'main.jpg')
# drinks_category.image.attach(io: File.open('app/assets/images/database_seed/drinks.jpg'), filename: 'drinks.jpg')
# antipasti_category.image.attach(io: File.open('app/assets/images/database_seed/antipasti.jpg'), filename: 'antipasti.jpg')

# penne_pomodoro.image.attach(io: File.open('app/assets/images/database_seed/penne-pomodoro.jpg'), filename: 'penne-pomodoro.jpg')
# pizza_julietta.image.attach(io: File.open('app/assets/images/database_seed/pizza-julietta.jpg'), filename: 'pizza-julietta.jpg')
# plank.image.attach(io: File.open('app/assets/images/database_seed/plank.jpg'), filename: 'plank.jpg')
# pork.image.attach(io: File.open('app/assets/images/database_seed/pork-chop.jpg'), filename: 'pork-chop.jpg')                
# coco_cola.image.attach(io: File.open('app/assets/images/database_seed/coca-cola.jpg'), filename: 'coca-cola.jpg')

def attach_image(object, path, filename) 
  unless objec.image.attached?
    object.image.attach(io: File.open(path), filename: filename)
  end
end


# Create Orders 

def create_order_with_status(user, status) 
  pizza_julietta = FoodItem.find(2)
  coca_cola = FoodItem.find(5)
  plank = FoodItem.find(3)
  order = Order.create(user: user, status: status)
  order.order_items.create(food_item: pizza_julietta, quantity: 2)
  order.order_items.create(food_item: coca_cola, quantity: 3)
  order.order_items.create(food_item: plank, quantity: 1)
end

user_1 = User.find(3) 

create_order_with_status(user_1, "ordered")
create_order_with_status(user_1, "completed")

user_2 = User.find(4)

create_order_with_status(user_2, "ordered")
create_order_with_status(user_2, "completed")

user_3 = User.find(5)

create_order_with_status(user_3, "ordered")
create_order_with_status(user_3, "completed")



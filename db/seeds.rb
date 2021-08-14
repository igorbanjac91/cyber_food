User.create!(
  first_name: "admin",
  last_name: "admin",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)

User.create!(
  first_name: "John",
  last_name: "Smith",
  email: "user@gmail.com",
  password: "password",
  password_confirmation: "password"
)

10.times do |n|
  User.create!(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email(domain: 'example'),
    password: "password",
    password_confirmation: "password"
  )
end

# Categories

all = Category.find_or_create_by(name: "all")
pizza_category = Category.find_or_create_by(name: "pizza")
pasta_category = Category.find_or_create_by(name: "pasta")
mains_category = Category.find_or_create_by(name: "mains")
antipasti_category = Category.find_or_create_by(name: "antipasti")
drinks_category = Category.find_or_create_by(name: "drinks")

# Food Items

#--------- Antipasti -------------

plank = FoodItem.find_or_create_by(name: "Seasonal Vegetables Plank", 
                                   description: "Marinated & grilled pepper, courgette & aubergine with baby mozzarella, focaccia, grissini, olives & pickles",
                                   category: antipasti_category,
                                   price: 700)

tomato_bruschetta = FoodItem.find_or_create_by(name: "Tomato Brushcetta", 
                                               description: "Slow-roasted cherry tomatoes, whipped ricotta, basil & extra virgin olive oil",
                                               category: antipasti_category,
                                               price: 550)

cured_meat_plank = FoodItem.find_or_create_by(name: "Cured Meat Plank", 
                                              description: "Prosciutto, fennel salami, schiacciata piccante & mortadella with pâté crostini, baby mozzarella, pecorino & chilli jam, focaccia, olives & pickles",
                                              category: antipasti_category,
                                              price: 750)

smoked_salmon = FoodItem.find_or_create_by(name: "Smoked Salmon Pate Brushcetta", 
                                           description: "Smoked salmon pate, tangy chive butter & bronze fennel ",
                                           category: antipasti_category,
                                           price: 650)

ultimate_plank = FoodItem.find_or_create_by(name: "Ultimate Plank", 
                                            description: "Prosciutto, fennel salami, schiacciata piccante & mortadella with pâté crostini, baby mozzarella, pecorino & chilli jam, focaccia, olives & pickles, mushroom & ravioli fritti",
                                            category: antipasti_category,
                                            price: 750)

#--------- Pasta -------------

penne_pomodoro = FoodItem.find_or_create_by(name: "Penne Pomodoro",
                                            description: "Sweet tomato sauce, garlic, basil, mascarpone, mozzarella,Italian hard cheese & herby breadcrumbs", 
                                            category: pasta_category,
                                            price: 1220)               

prawn_linguine = FoodItem.find_or_create_by(name: "Prawn Linguine",
                                            description: "Garlicky prawns with tomatoes, fennel, saffron, fresh chilli & rocket", 
                                            category: pasta_category,
                                            price: 1450)               

caserecce_genevose = FoodItem.find_or_create_by(name: "Caserecce Genovese",
                                                description: "Jamie's herby almond pesto, cherry tomatoes, Parmesan & extra virgin olive oil", 
                                                category: pasta_category,
                                                price: 1220)               

potato_gnocchi = FoodItem.find_or_create_by(name: "Potato Gnocchi",
                                            description: "Creamy blue cheese sauce, walnuts, seasonal greens, Parmesan and fried sage", 
                                            category: pasta_category,
                                            price: 1220)               

porcini_tagliatelle = FoodItem.find_or_create_by(name: "Porcini Tagliatelle",
                                                 description: "Wild mushrooms with mascarpone, garlic, white wine, lemony gremolata, Parmesan & herby breadcrumbs", 
                                                 category: pasta_category,
                                                 price: 1350)               



#--------- Pizza -------------

pizza_julietta = FoodItem.find_or_create_by(name: "Julietta",
                                            description: "Slow-roasted tomatoes, basil, the best buffalo mozzarella & aged Parmesan", 
                                            category: pizza_category,
                                            price: 1280)

the_porky = FoodItem.find_or_create_by(name: "The Porkie",
                                        description: "Sweet tomato sauce with schiacciata piccante, smoky pancetta, mozzarella & oregano", 
                                        category: pizza_category,
                                        price: 1290)

the_tuscan = FoodItem.find_or_create_by(name: "The Tuscan",
                                        description: "Sweet tomato sauce with Tuscan fennel salami, mozzarella, Kalamata olives, oregano & Parmesan", 
                                        category: pizza_category,
                                        price: 1320)

four_cheese = FoodItem.find_or_create_by(name: "Four Cheese",
                                         description: "Mozzarella, Cheddar, fontal & veggie Parmesan with rocket & extra virgin olive oil", 
                                         category: pizza_category,
                                         price: 1290)

the_parma = FoodItem.find_or_create_by(name: "The Parma",
                                       description: "Crushed tomatoes, mozzarella, Parma ham & rocket", 
                                       category: pizza_category,
                                       price: 1350)

#--------- Main -------------

pork = FoodItem.find_or_create_by(name: "Pork Chop Panzanella",
                                  description: "With smashed ricotta & feta, cherry tomato panzanella salad & fresh oregano, served with spiced fries", 
                                  category: mains_category,
                                  price: 1380)      

italian_burger = FoodItem.find_or_create_by(name: "Italian Burger",
                                            description: "Prime beef patty with pancetta, balsamic onions, artisan Cheddar, tomato & our house special sauce in a brioche bun, served with spiced fries", 
                                            category: mains_category,
                                            price: 1250)      

veggie_burger = FoodItem.find_or_create_by(name: "Veggie Burger",
                                           description: "Herby chickpea, bean & six-seed patty with balsamic onions, cottage cheese, gem & tomato in a brioche bun, served with spiced fries", 
                                           category: mains_category,
                                           price: 1250)      

tartufo_burger = FoodItem.find_or_create_by(name: "Tartufo Burger",
                                            description: "Prime beef patty in a brioche bun, truffle mayo, tomato, melted fontal, shoestring potatoes and balsamic onions", 
                                            category: mains_category,
                                            price: 1380)      

fish_in_a_bag = FoodItem.find_or_create_by(name: "Fish In a Bag",
                                           description: "Norwegian Salmon with baby potatoes, green beans, olives & crushed tomatoes, baked in a bag & topped with garlic mayo", 
                                           category: mains_category,
                                           price: 1750)      

#--------- Drinks -------------


coca_cola = FoodItem.find_or_create_by(name: "Coca Cola",
                                       description: "Origianal Coca Cola", 
                                       category: drinks_category,
                                       price: 250)               
                
fanta = FoodItem.find_or_create_by(name: "Fanta",
                                   description: "Original Fanta", 
                                   category: drinks_category,
                                   price: 250)               

sparklin_water = FoodItem.find_or_create_by(name: "Sparklin Water",
                                            description: "water with bubbles", 
                                            category: drinks_category,
                                            price: 150)               
                
beer = FoodItem.find_or_create_by(name: "Beer",
                                  description: "Dry Beer", 
                                  category: drinks_category,
                                  price: 200)               
                
wine = FoodItem.find_or_create_by(name: "Red Wine",
                                  description: "Red Wine from Tuscany", 
                                  category: drinks_category,
                                  price: 500)               
                


# Attach images 

def attach_image(object, path, filename) 
  unless object.image.attached?
    object.image.attach(io: File.open(path), filename: filename)
  end
end

# --- Categories

attach_image(all, 'app/assets/images/database_seed/all.jpg', 'all.jpg')
attach_image(antipasti_category, 'app/assets/images/database_seed/antipasti.jpg', 'antipasti.jpg')
attach_image(pizza_category, 'app/assets/images/database_seed/pizzas.jpg', 'pizzas.jpg')
attach_image(pasta_category, 'app/assets/images/database_seed/pastas.jpg', 'pastas.jpg')
attach_image(mains_category, 'app/assets/images/database_seed/main.jpg', 'main.jpg')
attach_image(drinks_category, 'app/assets/images/database_seed/drinks.jpg', 'drinks.jpg')

# --- Food Items

attach_image(plank, 'app/assets/images/database_seed/plank.jpg', 'plank.jpg')
attach_image(tomato_bruschetta, 'app/assets/images/database_seed/bruschetta.jpg', 'bruschcetta.jpg')
attach_image(cured_meat_plank, 'app/assets/images/database_seed/meat-plank.jpg', 'meat-plank.jpg')
attach_image(smoked_salmon, 'app/assets/images/database_seed/smoked-salmon.jpg', 'smoked-salmon.jpg')
attach_image(ultimate_plank, 'app/assets/images/database_seed/ultimate-plank.jpg', 'ultimate-plank.jpg')

attach_image(penne_pomodoro, 'app/assets/images/database_seed/penne-pomodoro.jpg', 'penne-pomodoro.jpg')
attach_image(prawn_linguine, 'app/assets/images/database_seed/linguine.jpg', 'linguine.jpg')
attach_image(caserecce_genevose, 'app/assets/images/database_seed/caserecce.jpg', 'caserecce.jpg')
attach_image(potato_gnocchi, 'app/assets/images/database_seed/gnocchi.jpg', 'gnocchi.jpg')
attach_image(porcini_tagliatelle, 'app/assets/images/database_seed/tagliatelle.jpg', 'tagliatelle.jpg')

attach_image(pizza_julietta, 'app/assets/images/database_seed/pizza-julietta.jpg', 'pizza-julietta.jpg')
attach_image(the_porky, 'app/assets/images/database_seed/the-porky.jpg', 'the-porky.jpg')
attach_image(the_tuscan, 'app/assets/images/database_seed/the-tuscan.jpg', 'the-tuscan.jpg')
attach_image(the_parma, 'app/assets/images/database_seed/the-parma.jpg', 'the-parma.jpg')
attach_image(four_cheese, 'app/assets/images/database_seed/four-cheese.jpg', 'four-cheese.jpg')

attach_image(pork, 'app/assets/images/database_seed/pork-chop.jpg', 'pork-chop.jpg')
attach_image(italian_burger, 'app/assets/images/database_seed/italian-burger.jpg', 'italian-burger.jpg')
attach_image(veggie_burger, 'app/assets/images/database_seed/veggie-burger.jpg', 'veggie-burger.jpg')
attach_image(tartufo_burger, 'app/assets/images/database_seed/tartufo-burger.jpg', 'tartufo-burger.jpg')
attach_image(fish_in_a_bag, 'app/assets/images/database_seed/fish-and-chips.jpg', 'fish-and-chips.jpg')

attach_image(coca_cola, 'app/assets/images/database_seed/coca-cola.jpg', 'coca-cola.jpg')
attach_image(fanta, 'app/assets/images/database_seed/fanta.jpg', 'fanta.jpg')
attach_image(sparklin_water, 'app/assets/images/database_seed/sparkling-water.jpg', 'sparkling-water.jpg')
attach_image(beer, 'app/assets/images/database_seed/beer.jpg', 'beer.jpg')
attach_image(wine, 'app/assets/images/database_seed/red-wine.jpg', 'red-wine.jpg')


# Create Orders 

def create_order_with_status(user, status) 
  food_item = 
  order = Order.create(user: user, status: status)
  3.times do 
    food_item = FoodItem.find(rand(FoodItem.first.id..FoodItem.last.id))
    order.order_items.create(food_item: food_item, quantity: rand(1..3))
  end
end

10.times do |n|
  user = User.find(n + 1)
  create_order_with_status(user, "ordered")
  create_order_with_status(user, "completed")
  create_order_with_status(user, "completed")
  create_order_with_status(user, "completed")
  create_order_with_status(user, "completed")
end



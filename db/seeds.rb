
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
pasta_category = Category.create(name: "pasta")
mains_category = Category.create(name: "mains")
antipasti_category = Category.create(name: "antipasti")
drinks_category = Category.create(name: "drinks")


FoodItem.create(name: "Seasonal Vegetables Plank", 
                description: "Marinated & grilled pepper, courgette & aubergine with baby mozzarella, focaccia, grissini, olives & pickles",
                category: antipasti_category,
                price: 7.00)

FoodItem.create(name: "Julietta",
                description: "Slow-roasted tomatoes, basil, the best buffalo mozzarella & aged Parmesan", 
                category: pizza_category,
                price: 12.80)

FoodItem.create(name: "Pork Chop Panzanella",
                description: "With smashed ricotta & feta, cherry tomato panzanella salad & fresh oregano, served with spiced fries", 
                category: mains_category,
                price: 13.80)      

FoodItem.create(name: "Penne Pomodoro",
                description: "Sweet tomato sauce, garlic, basil, mascarpone, mozzarella,Italian hard cheese & herby breadcrumbs", 
                category: pasta_category,
                price: 12.20)               

FoodItem.create(name: "Coca Cola",
                description: "Origianal Coca Cola", 
                category: drinks_category,
                price: 2.50)                
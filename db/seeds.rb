require 'open-uri'
require 'nokogiri'
require 'json'

puts "Cleaning database..."
TicketLine.destroy_all
Item.destroy_all
Ticket.destroy_all
Product.destroy_all
Favorite.destroy_all

User.destroy_all

puts "Creating users..."
victor = User.create(first_name: 'Victor', last_name: 'Branger', email: 'victor@gmail.com', password: '123456')
elsa = User.create(first_name: 'Elsa', last_name: 'Lebas', email: 'elsa@gmail.com', password: '123456')
pierre = User.create(first_name: 'Pierre', last_name: 'Riedinger', email: 'pierre@gmail.com', password: '123456')
vincent = User.create(first_name: 'Vincent', last_name: 'Huché', email: 'vincent@gmail.com', password: '123456')
thibaud = User.create(first_name: 'Thibaud', last_name: 'Maurel', email: 'thibaud@gmail.com', password: '123456')


def clean_category(off_category)
  if off_category.include?("en:meats") || off_category.include?("en:seafood")
    return "Viandes et poissons"
  elsif off_category.include?("en:fresh-vegetables") || off_category.include?("en:fruits")
    return "Fruits et légumes"
  elsif off_category.include?("en:non-food-products")
    return "Produits non alimentaires"
  elsif off_category.include?("en:boissons") || off_category.include?("en:beverages")
    return "Boissons"
  elsif off_category.include?("en:dairies")
    return "Produits laitiers"
  elsif off_category.include?("en:snacks")
    return "Snacks"
  elsif off_category.include?("en:viennoiseries") || off_category.include?("en:breads")
    return "Pains et patisseries"
  elsif off_category.include?("en:frozen-foods")
    return "Surgelés"
  elsif off_category.include?("en:desserts")
    return "Desserts"
  elsif off_category.include?("en:plant-based-foods-and-beverages")
    return "Produits d'origine végétale"
  else
    return "Autres"
  end
end


puts "Creating Products ALTERNATIVES FOR MADELEINES"

bar_codes = [ 3560071232726, 3701005300405, 3178530414943, 3564700046821]

bar_codes.each do |bar_code|
  url = "https://world.openfoodfacts.org/api/v0/product/#{bar_code}.json"
  product_serialized = open(url).read
  product = JSON.parse(product_serialized)

    if product["product"]["ecoscore_data"]
      puts "#{product["product"]["product_name_fr"]} // #{bar_code} "
      new_product = Product.create(
        score: product["product"]["ecoscore_data"]["score"],
        bar_code: bar_code,
        category: clean_category(product["product"]["categories_tags"]),
        name: product["product"]["product_name_fr"],
        photo: product["product"]["selected_images"]["front"]["small"].first[1],
        generic_name: product["product"]["generic_name"],
        brand: product["product"]["brands"],
        category_agribalyse: product["product"]["categories_properties"]["agribalyse_food_code:en"],
        ecoscore_grade: product["product"]["ecoscore_grade"],
        nutriscore_grade: product["product"]["nutriscore_grade"]
        )
        if new_product.score.nil?
          new_product.destroy
        else
          Item.create(description: new_product[:name], product_id: new_product.id)
        end
    end
end

puts "Done !! "


# CREATING 3 TICKETS WITH BAD SCORE
puts "Creating 1 tickets for Elsa / U Express with a bad score"

items_uexpress = []
bar_codes = [4006040021520, 3222476448149, 3265470035861, 3560070262595, 80052043]

puts "#{product["product"]["product_name_fr"]} // #{bar_code} "
  new_product = Product.create(
    score: product["product"]["ecoscore_data"]["score"],
    bar_code: bar_code,
    category: clean_category(product["product"]["categories_tags"]),
    name: product["product"]["product_name_fr"],
    photo: product["product"]["selected_images"]["front"]["small"].first[1],
    generic_name: product["product"]["generic_name"],
    brand: product["product"]["brands"],
    category_agribalyse: product["product"]["categories_properties"]["agribalyse_food_code:en"],
    ecoscore_grade: product["product"]["ecoscore_grade"],
    nutriscore_grade: product["product"]["nutriscore_grade"]
    )
    if new_product.score.nil?
      new_product.destroy
    else
      items_uexpress << Item.create(description: new_product[:name], product_id: new_product.id)
    end
end

items_uexpress_description = []

items_uexpress.each do |item|
  items_uexpress_description << item.description
end

items_uexpress_description.join(",")

new_ticket = Ticket.create(
    store: "U Express",
    user_id: elsa.id,
    photo: items_uexpress_description
    )

items_uexpress.each do |item|
    TicketLine.create(
      ticket_id: new_ticket.id,
      item_id: item.id,
      quantity: 1)
end



puts "Creating 1 tickets for Elsa / CARREFOUR with a bad score"

items_carrefour = []

bar_codes = [20460204, 3270190021001, 20143077, 3660140917759, 3250392046255]
bar_codes.each do |bar_code|
  url = "https://world.openfoodfacts.org/api/v0/product/#{bar_code}.json"
  product_serialized = open(url).read
  product = JSON.parse(product_serialized)
  puts "#{product["product"]["product_name_fr"]} // #{bar_code} "
  new_product = Product.create(
    score: product["product"]["ecoscore_data"]["score"],
    bar_code: bar_code,
    category: clean_category(product["product"]["categories_tags"]),
    name: product["product"]["product_name_fr"],
    photo: product["product"]["selected_images"]["front"]["small"].first[1],
    generic_name: product["product"]["generic_name"],
    brand: product["product"]["brands"],
    category_agribalyse: product["product"]["categories_properties"]["agribalyse_food_code:en"],
    ecoscore_grade: product["product"]["ecoscore_grade"],
    nutriscore_grade: product["product"]["nutriscore_grade"]
    )
    if new_product.score.nil?
      new_product.destroy
    else
      items_carrefour << Item.create(description: new_product[:name], product_id: new_product.id)
    end
end


items_carrefour_description = []

items_carrefour.each do |item|
  items_carrefour_description << item.description
end

items_carrefour_description.join(",")

new_ticket = Ticket.create(
    store: "Carrefour",
    user_id: elsa.id,
    photo: items_carrefour_description
    )

items_carrefour.each do |item|
    TicketLine.create(
      ticket_id: new_ticket.id,
      item_id: item.id,
      quantity: 1)
  end



puts "Creating 1 tickets for Elsa / DEFAULT with a bad score"

items_default = []

bar_codes = [3263858780211, 2019000051972, 3045320001693, 3307902060086]
bar_codes.each do |bar_code|
  url = "https://world.openfoodfacts.org/api/v0/product/#{bar_code}.json"
  product_serialized = open(url).read
  product = JSON.parse(product_serialized)
  puts "#{product["product"]["product_name_fr"]} // #{bar_code} "
  new_product = Product.create(
    score: product["product"]["ecoscore_data"]["score"],
    bar_code: bar_code,
    category: clean_category(product["product"]["categories_tags"]),
    name: product["product"]["product_name_fr"],
    photo: product["product"]["selected_images"]["front"]["small"].first[1],
    generic_name: product["product"]["generic_name"],
    brand: product["product"]["brands"],
    category_agribalyse: product["product"]["categories_properties"]["agribalyse_food_code:en"],
    ecoscore_grade: product["product"]["ecoscore_grade"],
    nutriscore_grade: product["product"]["nutriscore_grade"]
    )
    if new_product.score.nil?
      new_product.destroy
    else
      items_default << Item.create(description: new_product[:name], product_id: new_product.id)
    end
end


items_default_description = []

items_default.each do |item|
  items_default_description << item.description
end

items_default_description.join(",")

new_ticket = Ticket.create(
    user_id: elsa.id,
    photo: items_default_description
    )

items_default.each do |item|
    TicketLine.create(
      ticket_id: new_ticket.id,
      item_id: item.id,
      quantity: 1)
end

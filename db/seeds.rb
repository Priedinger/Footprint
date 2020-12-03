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


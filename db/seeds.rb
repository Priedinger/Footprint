puts "Cleaning database..."
TicketLine.destroy_all
Item.destroy_all
Ticket.destroy_all
Product.destroy_all

User.destroy_all

puts "Creating users..."
victor = User.create(first_name: 'Victor', last_name: 'Branger', email: 'victor@gmail.com', password: '123456')
elsa = User.create(first_name: 'Elsa', last_name: 'Lebas', email: 'elsa@gmail.com', password: '123456')
pierre = User.create(first_name: 'Pierre', last_name: 'Riedinger', email: 'pierre@gmail.com', password: '123456')
vincent = User.create(first_name: 'Vincent', last_name: 'Huché', email: 'vincent@gmail.com', password: '123456')
thibaud = User.create(first_name: 'Thibaud', last_name: 'Maurel', email: 'thibaud@gmail.com', password: '123456')

puts "creating 7 items associated to products > identified items"
# liste de course associée : Eau de source Cristalline,Flan caramel 2 vaches,Mozzarella Galbani,Champagne Muum,Crevettes Delp,Madeleine Pep Choco,Chips Tyr

puts "1 - creating Eau Cristalline"
eau_cristalline = Product.new(
  bar_code: "3274080005003",
  category: "en:boissons",
  name: "Eau de source",
  photo: "https://static.openfoodfacts.org/images/products/327/408/000/5003/front_fr.609.200.jpg",
  generic_name: "Eau de source naturelle",
  brand: "Cristalline,cristal-roc")
eau_cristalline.save

eau_cristalline_item = Item.new(description: "Eau de source Cristalline", product_id: eau_cristalline.id)
eau_cristalline_item.save

puts "2 - creating Flan Les 2 vaches"
flan_caramel_2_vaches = Product.new(
  bar_code: "3661344795372",
  category: "en:dairies",
  name: "Flan Bio à la vanille nappé de caramel",
  photo: "https://static.openfoodfacts.org/images/products/366/134/479/5372/front_fr.30.200.jpg",
  generic_name: "Flan Bio à la vanille nappé de caramel",
  brand: "Les 2 vaches",
)
flan_caramel_2_vaches.save

flan_caramel_2_vaches_item = Item.new(description: "Flan caramel 2 vaches", product_id: flan_caramel_2_vaches.id)
flan_caramel_2_vaches_item.save


puts "3 - creating Mozza"
mozzarella_galbani = Product.new(
  bar_code: "8000430138719",
  category: "en:dairies",
  name: "Mozzarella",
  photo: "https://static.openfoodfacts.org/images/products/800/043/013/8719/front_fr.68.200.jpg",
  generic_name: "",
  brand: "Galbani")
mozzarella_galbani.save

mozzarella_galbani_item = Item.new(description: "Mozzarella Galbani", product_id: mozzarella_galbani.id)
mozzarella_galbani_item.save

puts "4 - creating Champagne"
champagne_mumm = Product.new(
  bar_code: "3043700103715",
  category: "en:beverages",
  name: "Cordon Rouge",
  photo: "https://static.openfoodfacts.org/images/products/304/370/010/3715/front_fr.11.200.jpg",
  generic_name: "Champagne brut",
  brand: "Mumm"
  )
champagne_mumm.save

champagne_mumm_item = Item.new(description: "Champagne Muum", product_id: champagne_mumm.id)
champagne_mumm_item.save

puts "5 - creating Crevettes"
crevettes_dec = Product.new(
  bar_code: "3336374402247",
  category: "en:seafood",
  name: "Crevettes décortiquées nature",
  photo: "https://static.openfoodfacts.org/images/products/333/637/440/2247/front_fr.24.200.jpg",
  generic_name: "crevettes décortiquées cuites réfrigérées",
  brand: "Delpierre")
crevettes_dec.save

crevettes_dec_item = Item.new(description: "Crevettes Delp", product_id: crevettes_dec.id)
crevettes_dec_item.save


puts "6 - creating Madeleine"
madeleine = Product.new(
  bar_code: "3178530410143",
  category: "en:snacks",
  name: "Petites Madeleine pépites chocolat",
  photo: "https://static.openfoodfacts.org/images/products/317/853/041/0143/front_fr.74.200.jpg",
  generic_name: "Madeleines aux pépites de chocolat (5%) et pépites de chocolat au lait (2,7%)",
  brand: "St Michel")
madeleine.save

madeleine_item = Item.new(description: "Madeleine Pep Choco", product_id: madeleine.id)
madeleine_item.save

puts "7 - creating Chips"
chips = Product.new(
  bar_code: "5056051802464",
  category: "en:snacks",
  name: "Tyrells swanky veg",
  photo: "https://static.openfoodfacts.org/images/products/505/605/180/2464/front_fr.3.200.jpg",
  generic_name: "Chips de panais, patate douce et banane plantain.",
  brand: "Tyrrells")
chips.save


chips_item = Item.new(description: "Chips Tyr", product_id: chips.id)
chips_item.save

puts "8 - creating Camembert"
camembert = Product.new(
  bar_code: "3275240312016",
  category: "en:dairies",
  name: "Camembert",
  photo:
  "https://static.openfoodfacts.org/images/products/327/524/031/2016/front_fr.64.200.jpg",
  generic_name: "Camembert au lait pasteurisé",
  brand: "Bons Mayennais,Vaubernier")
camembert.save


camembert_item = Item.new(description: "Camembert", product_id: chips.id)
camembert_item.save

puts "9 - creating Eau Mont Rouc"
eau_roucous = Product.new(
  bar_code: "3257971309114",
  category: "en:beverages",
  name: "Eau minérale naturelle",
  photo:
  "https://static.openfoodfacts.org/images/products/325/797/130/9114/front_fr.25.200.jpg",
  generic_name: "",
  brand: "Mont Roucous"
  )
eau_roucous.save

eau_roucous_item = Item.new(description: "Eau Mont Rouc", product_id: eau_roucous.id )
eau_roucous_item.save

puts "10 - creating Creme Vanille Danette"

danette = Product.new(
  bar_code: "3033491279720",
  category: "en:dairies",
  name: "Danette vanille",
  photo:
  "https://static.openfoodfacts.org/images/products/303/349/127/9720/front_fr.21.200.jpg",
  generic_name: "Crèmes dessert saveur vanille",
  brand: "Danette")
danette.save

danette_item = Item.new(description: "Creme Vanille Danette", product_id: danette.id)
danette_item.save


puts "Adding 4 products to Favorites for Elsa"

puts "Add chips"
chips_fav = Favorite.create(user_id: elsa.id, product_id: chips.id)

puts "Add madeleine"
madeleine_fav = Favorite.create(user_id: elsa.id, product_id: madeleine.id)

puts "Crevettes"
crevettes_dec_fav = Favorite.create(user_id: elsa.id, product_id: crevettes_dec.id)

puts "Mozza"
mozzarella_galbani_fav = Favorite.create(user_id: elsa.id, product_id: mozzarella_galbani.id)

puts "Finished!"

product.score = score dans le schema

Le product.score doit etre compris entre 0 et 100
  Si > 100 => Product.score = 100
  Si <0 => product.score = 0

==>> MODIF DANS LE SCHEMA OU DANS UNE METHODE ?

Retraitement du score ne fonction de nutri et eco
  si product.ecoscore_grade == "b"
    alors product.score -= 10
  si product.ecoscore_grade == "c" ou ""

 Product.score

const String qDetailledPanier = r'''
query getDetailledPanier($id: ID) {
  panier {
    id
    name
    description
    category
    quantity
    price
    products {
      quantity
      product {
        id
        name
      }
    }
  }
}
'''; 

const String qPanierCommerce = r'''
query getPanierCommerce(
  $commerceID: ID
) {
  commerce(id: $commerceID) {
    id,
    name,
    categories,
    
  }
}
'''; 

const String mutCreatePanier = r'''
mutation createPanier(
  $commerce: ID,
  $name: String!,
  $description: String!,
  $category: String!,
  $quantity: Int!,
  $price: Float!,
  $image: Upload,
  $products: [NewPanierProduct!]!
) {
  createPanier(commerceID: $commerce, input: {
    name: $name,
    description: $description,
    category: $category,
    quantity: $quantity,
    price: $price,
    image: $image,
    products: $products
  }) {
    id,
    name
  }
}
''';
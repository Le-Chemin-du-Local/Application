const String qPaniers = r'''
query getPaniers(
  $commerceID: ID,
  $category: String!
) {
  commerce(id: $commerceID) {
    id
    name
    paniers(filters: {
      category: $category
    }) {
      edges {
        node {
          id
          name
          category
          description
          products {
            quantity
            product {
              name
              price
            }
          }
        }
      }
    }
  }
}
''';
const String qDetailledPanier = r'''
query getDetailledPanier($id: ID!) {
  panier(id: $id) {
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

const String mutUpdatePanier = r'''
mutation createPanier(
  $id: ID!,
  $name: String!,
  $description: String!,
  $category: String!,
  $quantity: Int!,
  $price: Float!,
  $image: Upload,
  $products: [NewPanierProduct!]!
) {
  updatePanier(id: $id, changes: {
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
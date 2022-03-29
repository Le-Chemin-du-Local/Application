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
          endingDate
        }
      }
    }
  }
}
''';

const String qAllPaniers = r'''
query getPaniers(
  $commerceID: ID,
) {
  commerce(id: $commerceID) {
    id
    name
    paniers {
      edges {
        node {
          id
          name
          category
          quantity
          price
          description
          endingDate
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
    endingDate
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
  $endingDate: Time,
  $products: [NewPanierProduct!]!
) {
  createPanier(commerceID: $commerce, input: {
    name: $name,
    description: $description,
    category: $category,
    quantity: $quantity,
    price: $price,
    image: $image,
    endingDate: $endingDate
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
  $endingDate: Time,
  $products: [NewPanierProduct!]!
) {
  updatePanier(id: $id, changes: {
    name: $name,
    description: $description,
    category: $category,
    quantity: $quantity,
    price: $price,
    image: $image,
    endingDate: $endingDate,
    products: $products
  }) {
    id,
    name
  }
}
''';
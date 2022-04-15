const String qPaniers = r'''
query getPaniers(
  $commerceID: ID,
  $type: String!
) {
  commerce(id: $commerceID) {
    id
    name
    paniers(filters: {
      type: $type
    }) {
      edges {
        node {
          id
          name
          type
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
          type
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
    type
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

const String qPanierCommandsMini = r'''
query commerce($status: String!) {
commerce {
  panierCommands(
    filters: {
      status: $status 
    }
  ) {
    edges {
      node {
        id
        status
        pickupDate
        panier {
          id
          name
          type
          category
          price
        }
        user {
          id
          role
          email
          firstName
          lastName
        }
      }
    }
  }
  }
}
''';

const String qPanierCommandDetails = r'''
query paniercommandDetails($id: ID!) {
  paniercommand(id: $id) {
    status
    pickupDate
    panier {
      id
      name
      type
      category
      price
      products {
        quantity
        product {
          name
          price
          categories
        }
      }   
    }
    user {
      role
      email
      firstName
      lastName
    }
  }
}
''';

const String mutCreatePanier = r'''
mutation createPanier(
  $commerce: ID,
  $name: String!,
  $description: String!,
  $type: String!,
  $quantity: Int!,
  $price: Float!,
  $image: Upload,
  $endingDate: Time,
  $products: [NewPanierProduct!]!
) {
  createPanier(commerceID: $commerce, input: {
    name: $name,
    description: $description,
    type: $type,
    category: "Autre",
    quantity: $quantity,
    price: $price,
    reduction: 0,
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
  $type: String!,
  $quantity: Int!,
  $price: Float!,
  $image: Upload,
  $endingDate: Time,
  $products: [NewPanierProduct!]!
) {
  updatePanier(id: $id, changes: {
    name: $name,
    description: $description,
    type: $type,
    category: "Autre",
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


const String mutUpdatePanierCommand = r'''
mutation updatePanierCommand($id: ID!, $status: String!) {
  updatePanierCommand(
    id: $id,
    changes: {
      status: $status
    }
  ) {
    id
    status
  }
}
''';
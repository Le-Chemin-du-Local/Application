const String qProductsAvailableForClickAndCollect = r'''
query productsAvailableForClickAndCollect($commerceID: ID) {
commerce(id: $commerceID) {
  id
  name
  productsAvailableForClickAndCollect {
    id
    name
  }
}
}
''';

const String qCCCommandsMini = r'''
query commerce($status: String!) {
commerce {
  cccommands(
    filters: {
      status: $status 
    }
  ) {
    edges {
      node {
        id
        status
        pickupDate
        products {
          quantity
          product {
            name
            price
          }
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

const String qCCCommandDetails = r'''
query cccommandDetails($id: ID!) {
  cccommand(id: $id) {
    status
    pickupDate
    products {
      quantity
      product {
        name
        price
        categories
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

const String mutUpdateCCProductsAvailability = r'''
mutation updateProductsAvailableForClickAndCollect(
  $id: ID!
  $productsIDs: [ID!]!
) {
  updateCommerce(
    id: $id,
    changes: {
      productsAvailableForClickAndCollect: $productsIDs
    }
  ) {
    id
    name
  }
}
''';

const String mutUpdateCCCommand = r'''
mutation updateCCCommand($id: ID!, $status: String!) {
  updateCCCommand(
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
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
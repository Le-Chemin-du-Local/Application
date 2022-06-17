const String qGetCommandsMini = r'''
query getCommands(
  $first: Int
  $filter: CommandsFilter
) {
  commands(first: $first, filter: $filter) {
    edges {
      node {
        id
        creationDate
        commerces {
          commerce {
            name
            address {
              number
              route
              optionalRoute
              postalCode
              city
            }
          }
          status
          pickupDate
        }
      }
    }
  }
}
''';

const String qGetCommandDetailed = r'''
query getCommand(
  $id: ID!
) {
  command(id: $id) {
    id
    creationDate
    commerces {
      id
      commerce {
        id
        name
        address {
          number
          route
          optionalRoute
          postalCode
          city
        }
        phone
      }
      price
      cccommands {
        id
        products {
          quantity
          product {
            id
            name
            price
          }
        }
      }
      status
      pickupDate
    }
  }
}
''';

const String mutUpdateCommerceCommand = r'''
mutation updateCommerceCommand(
  $id: ID!
  $changes: ChangesCommerceCommand!
) {
  updateCommerceCommand(
    id: $id, 
    changes: $changes
  ) {
    id
    commerce {
      name
    }
    status
  }
}
''';
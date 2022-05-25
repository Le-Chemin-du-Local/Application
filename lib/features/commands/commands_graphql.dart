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
            address
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
        address
        phone
      }
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
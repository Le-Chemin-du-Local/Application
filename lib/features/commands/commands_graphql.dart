const String qGetCommandsMini = r'''
query getCommands(
  $first: Int
  $filter: CommandsFilter
) {
  commands(first: $first, filter: $filter) {
    edges {
      node {
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
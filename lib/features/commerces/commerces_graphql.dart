const String qCommercesMini = r'''
query getCommerces(
  $nearLatitude: Float,
  $nearLongitude: Float,
) {
  commerces(
    filter: {
      nearLatitude: $nearLatitude,
      nearLongitude: $nearLongitude,
    }
  ) {
    edges {
      node {
        id
        storekeeper {
          id
          role
          email
        }
        name
        latitude
        longitude
        address
        services
      }
    }
  }
}
''';
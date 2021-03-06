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
        address {
          number
          route
          optionalRoute
          postalCode
          city
        }
        services
      }
    }
  }
}
''';

const String qCommerceMini = r'''
query getCommerceMini(
  $id: ID
) {
  commerce(id: $id) {
    id
    storekeeper {
      id
      role
      email
    }
    name
    latitude
    longitude
    address {
      number
      route
      optionalRoute
      postalCode
      city
    }
    services
  }
}
''';

const String mutCreateCommerce = r'''
mutation createCommerce(
  $userID: ID!
  $name: String!
  $address: NewAddress!
  $latitude: Float!
  $longitude: Float!
  $phone: String!
  $email: String!
) {
  createCommerce(
    userID: $userID
    input: {
      name: $name,
      address: $address,
      latitude: $latitude,
      longitude: $longitude,
      phone: $phone,
      email: $email
    }
  ) {
    id
    name
  }
}
''';
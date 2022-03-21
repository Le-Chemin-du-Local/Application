const String qGetStoreKeeperCommerce = r'''
query GetStoreKeeperCommerce(
  $id: ID
) {
  user(id: $id) {
    role
    email
    commerce {
      id
      name
      description
      address
      phone
      email,
      products(first: 6) {
        edges {
          node {
            id,
            name,
            price,
            unit,
            isBreton
          }
        },
        pageInfo {
          startCursor,
          endCursor,
          hasNextPage
        }
      }
    }
  }
}
''';
const String qGetStoreKeeperCommercePage = r'''
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
      storekeeperWord
      address
      phone
      email
      facebook
      twitter
      instagram
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

const String mutUpdateStorekeerCommercePage = r'''
mutation updateCommerce(
  $id: ID!,
  $storekeeperWord: String,
  $description: String,
  $address: String,
  $phone: String,
  $email: String,
  $facebook: String,
  $twitter: String,
  $instagram: String,
  $image: Upload,
  $profilePicture: Upload
) {
  updateCommerce(
    id: $id,
    changes: {
      storekeeperWord: $storekeeperWord,
      description: $description,
      address: $address,
      phone: $phone,
      email: $email,
      facebook: $facebook,
      twitter: $twitter,
      instagram: $instagram,
      image: $image,
      profilePicture: $profilePicture
    }
  ) {
    id
    name
  }
}
''';
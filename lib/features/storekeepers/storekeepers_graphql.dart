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
      latitude
      longitude
      phone
      email
      facebook
      twitter
      instagram
      businessHours {
        monday {
          opening
          closing
        }
        tuesday {
          opening
          closing
        }
        wednesday {
          opening
          closing
        }
        thursday {
          opening
          closing
        }
        friday {
          opening
          closing
        }
        saturday {
          opening
          closing
        }
        sunday {
          opening
          closing
        }
      }
      productsAvailableForClickAndCollect {
        id
        name
      }
      products(first: 6) {
        edges {
          node {
            id,
            name,
            price,
            unit,
            tva,
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
  $latitude: Float,
  $longitude: Float,
  $phone: String,
  $email: String,
  $facebook: String,
  $twitter: String,
  $instagram: String,
  $businessHours: ChangesBusinessHours,
  $image: Upload,
  $profilePicture: Upload
) {
  updateCommerce(
    id: $id,
    changes: {
      storekeeperWord: $storekeeperWord,
      description: $description,
      address: $address,
      latitude: $latitude,
      longitude: $longitude,
      phone: $phone,
      email: $email,
      facebook: $facebook,
      twitter: $twitter,
      instagram: $instagram,
      businessHours: $businessHours,
      image: $image,
      profilePicture: $profilePicture
    }
  ) {
    id
    name
  }
}
''';
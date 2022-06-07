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
      addressDetailed {
        number
        route
        optionalRoute
        postalCode
        city
      }
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
      clickAndCollectHours {
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
mutation updateCommerce($id: ID!, $changes: ChangesCommerce!) {
  updateCommerce(
    id: $id,
    changes: $changes,
  ) {
    id
    name
  }
}
''';
const String qCategories = r'''
query getCategories(
  $commerceID: ID
) {
  commerce(id: $commerceID) {
    id,
    name,
    categories
  }
}
''';

const String qMiniProductsForCategory = r'''
query getMiniProductsForCategory(
  $commerceID: ID,
  $category: String!
) {
  commerce(id: $commerceID) {
    id,
    name,
    products(filters: {
      category: $category
    }) {
      edges {
        node {
          id,
          name,
          price,
          unit,
          isBreton,
          hasGluten,
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
''';

const String qDetailledProduct = r'''
query getDetailledProduct(
  $productID: ID!
) {
  product(id: $productID) {
    id,
    name,
    description,
    categories,
    tags,
    allergens,
    description,
    isBreton,
    hasGluten,
    price,
    unit,
    tva,
  }
}
'''; 


const String qMiniProduct = r'''
query getDetailledProduct(
  $id: ID!
) {
  product(id: $id) {
    id,
    name,
    isBreton,
    hasGluten,
    price,
    unit,
    tva,
  }
}
'''; 

const String mutCreateProduct = r'''
mutation createProduct(
  $input: NewProduct!
) {
  createProduct(input: $input) {
    id, 
    name
  }
}
''';

const String mutCreateProducts = r'''
mutation createProducts(
  $input: [NewProduct!]!
) {
  createProducts(input: $input) {
    id
    name
  }
}
''';

const String mutUpdateProduct = r'''
mutation updateProduct(
  $id: ID!,
  $changes: ChangesProduct!
) {
  updateProduct(id: $id, changes: $changes) {
    id, 
    name
  }
}
''';
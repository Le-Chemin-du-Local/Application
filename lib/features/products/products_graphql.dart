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
    description,
    isBreton,
    price,
    unit,
    tva,
  }
}
'''; 

const String mutCreateProduct = r'''
mutation createProduct(
  $name: String!,
  $description: String!,
  $price: Float!,
  $unit: String!,
  $tva: Float!,
  $isBreton: Boolean!,
  $categories: [String!]!
  $image: Upload
) {
  createProduct(input: {
    name: $name,
    description: $description,
    price: $price,
    unit: $unit,
    tva: $tva,
    isBreton: $isBreton,
    categories: $categories,
    image: $image,
  }) {
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
  $name: String,
  $description: String,
  $price: Float,
  $unit: String,
  $tva: Float,
  $isBreton: Boolean,
  $categories: [String!],
  $image: Upload
) {
  updateProduct(id: $id, changes: {
    name: $name,
    description: $description,
    price: $price,
    unit: $unit,
    tva: $tva,
    isBreton: $isBreton,
    categories: $categories,
    image: $image,
  }) {
    id, 
    name
  }
}
''';
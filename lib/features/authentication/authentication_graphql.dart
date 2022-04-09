const String mutAuthentication = r'''
mutation login(
  $email: String!,
  $password: String!,
) {
  login(input: {
    email: $email,
    password: $password
  })
}
''';

const String mutRegisterUser = r'''
mutation register(
  $email: String!
  $password: String!
  $firstName: String!
  $lastName: String!
) {
  createUser(input: {
    email: $email
    password: $password
    firstName: $firstName
    lastName: $lastName
  }) {
    id
    firstName
  }
}
''';

const String qGetLoggedUser = r'''
query GetLoggedUser {
  user {
    id,
    createdAt
    email,
    role,
    commerce {
      name
      services
    }
  }
}
''';
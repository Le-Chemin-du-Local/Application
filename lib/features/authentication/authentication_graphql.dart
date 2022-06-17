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
  $newUser: NewUser!
) {
  createUser(input: $newUser) {
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
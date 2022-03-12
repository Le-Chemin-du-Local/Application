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

const String qGetLoggedUser = r'''
query GetLoggedUser {
  user {
    id,
    createdAt
    email,
    role,
  }
}
''';
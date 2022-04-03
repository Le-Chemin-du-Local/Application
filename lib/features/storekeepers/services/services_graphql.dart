const String qGetServicesForStoreKeeper = r'''
query GetServicesForStoreKeeper {
  user {
    id
    role
    email
    commerce {
      id
      name
      services
    }
  }
}
''';
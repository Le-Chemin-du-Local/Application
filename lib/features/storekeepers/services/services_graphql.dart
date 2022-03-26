const String qGetServicesForStoreKeeper = r'''
query GetServicesForStoreKeeper {
  user {
    role
    email
    commerce {
      name
      services
    }
  }
}
''';
const String qUserPaymentInfo = r'''
query getUserPaymentInfo($userID: ID) {
  user(id: $userID) {
    id
    role
    email
    registeredPaymentMethods {
      name
      stripeID
      cardBrand
      cardLast4Digits
    }
    defaultPaymentMethod {
      stripeID
    }
  }
}
''';
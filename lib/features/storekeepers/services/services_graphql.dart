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
      dueBalance
      firstBillingDate
    }
  }
}
''';

const String qAllServicesInfo = r'''
query GetAllServicesInfo {
  allServicesInfo {
    id
    name
    shortDescription
    longDescription
    monthPrice
    monthAdvantages
    monthMinimumAllowedCA
    monthRangePercentage
    monthAugmentationPerRangePercentage
    transactionPercentage
    transactionAdvantages
  }
}
''';
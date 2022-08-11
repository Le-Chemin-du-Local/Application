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
      lastBilledDate
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

const qServiceInfo = r'''
query serviceInfo($serviceID: String!) {
  serviceInfo(id: $serviceID) {
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

const String mutUpdateServices = r'''
mutation updateCommerceServices(
  $commerceID: ID!,
  $services: [ChangesService!]
) {
  updateCommerce(
    id: $commerceID,
    changes: {
      services: $services
    }
  ) {
    id
    name
  }
}
''';
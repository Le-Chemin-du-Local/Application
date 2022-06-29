const String qGetCommerceClickandcollectSchedule = r'''
query getCommerceClickandcollectSchedule(
  $id: ID
) {
  commerce(id: $id) {
    id
    name
    clickAndCollectHours {
      monday {
        opening
        closing
      }
      tuesday {
        opening
        closing
      }
      wednesday {
        opening
        closing
      }
      thursday {
        opening
        closing
      }
      friday {
        opening
        closing
      }
      saturday {
        opening
        closing
      }
      sunday {
        opening
        closing
      }
    }
  }
}
''';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Init {
  Init._();

  static final instance = Init._();

  Future initialize(GraphQLClient client, WidgetRef ref) async {
    await ref.read(appUserControllerProvider.notifier).initializeUser(client);
    await ref.read(basketControllerProvider.notifier).syncBasket(client);

    // TODO: discuss the delay
    await Future<void>.delayed(const Duration(milliseconds: 2500));
  }
}
import 'dart:io';

import 'package:chemin_du_local/core/graphql/graphql_client.dart';
import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/core/helpers/init.dart';
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/splash_screen.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/main_page/clients_main_page.dart';
import 'package:chemin_du_local/features/main_page/storekeepers_main_page.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:chemin_du_local/theme/cl_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DebugHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      // ..badCertificateCallback = (X509Certificate cert, String host, int port) {
      //   if (host == "localhost" && port == 8082) return true;

      //   return false;
      // };
  }
}

void main() async {
  HttpOverrides.global = DebugHttpOverrides();
  
  WidgetsFlutterBinding.ensureInitialized();

  // Strip initialisation
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    Stripe.publishableKey = kStripPublishableKey;
    Stripe.merchantIdentifier = "chemin.du.local.bzh";
    Stripe.urlScheme = "clstrip";
    await Stripe.instance.applySettings();
  }

  await initHiveForFlutter(); // For GraphQL cache
  await HiveStore.openBox(HiveStore.defaultBoxName);

  // TODO: DEBUG ONLY
  // const storage = FlutterSecureStorage();
  // await storage.delete(key: "user_username");
  // await storage.delete(key: "user_password");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? token = ref.watch(appUserControllerProvider).token;

    return GraphQLProvider(
      client: graphQLClient(token),
      child: MaterialApp(
        title: 'Le Chemin du Local',
        navigatorKey: AppManager.instance.appNavigatorKey,
        theme: ClTheme.theme(context),
        home: LayoutBuilder(
          builder: (context, constraints) {
            return GraphQLConsumer(
              builder: (client) => FutureBuilder<dynamic>(
                future: Init.instance.initialize(client, ref),
                builder: (context, snapshot) {
                  ScreenHelper.instance.setValues(constraints.maxWidth);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
            
                  token = ref.read(appUserControllerProvider).token;
            
                  if (token != null) {
                    // We need the user role
                    return Query<dynamic>(
                      options: QueryOptions<dynamic>(
                        document: gql(qGetLoggedUser),
                      ),
                      builder: (result, {fetchMore, refetch}) {
                        final User appUser = User.fromJson(result.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});
                
                
                        if (appUser.role == UserRoles.storeKeeper) {
                          return StoreKeepersMainPage(
                            storekeeper: appUser,
                          );
                        }
            
                        return ClientsMainPage(
                          returnToBasketPayment: ref.watch(appUserControllerProvider).goBackToBasketPayment,
                        );
                      },
                    );
                  }
            
                  return const ClientsMainPage();
                }
              ),
            );
          }
        ),
      ),
    );
  }
}
import 'package:chemin_du_local/core/graphql/graphql_client.dart';
import 'package:chemin_du_local/core/helpers/init.dart';
import 'package:chemin_du_local/core/widgets/splash_screen.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/clients/client_main_page/clients_main_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_main_page/storekeepers_main_page.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:chemin_du_local/theme/cl_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter(); // For GraphQL cache
  await HiveStore.openBox<dynamic>(HiveStore.defaultBoxName);

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
        // navigatorKey: AppManager.instance.appNavigatorKey,
        theme: ClTheme.theme(context),
        home: GraphQLConsumer(
          builder: (client) => FutureBuilder<dynamic>(
            future: Init.instance.initialize(client, ref),
            builder: (context, snapshot) {
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
                      return const StoreKeepersMainPage();
                    }

                    return const ClientsMainPage();
                  },
                );
              }

              return const ClientsMainPage();
            }
          ),
        ),
      ),
    );
  }
}
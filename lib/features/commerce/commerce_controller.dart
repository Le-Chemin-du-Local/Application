import 'package:chemin_du_local/features/commerce/commerce.dart';
import 'package:chemin_du_local/features/commerce/commerce_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commerceControllerProvider = StateNotifierProvider<CommerceController, CommerceState>((ref) {
  return CommerceController(
    const CommerceState(
      commerce: AsyncValue.loading()
    )
  );
});

class CommerceController extends StateNotifier<CommerceState> {
  CommerceController(CommerceState state) : super(state);

  Future loadData({String? authenticationHeader, bool refresh = false}) async {
    if (state.commerce.asData != null && !refresh) return;

    state = state.copyWith(commerce: const AsyncValue.loading());

    Commerce demo = const Commerce(
      description: "Description. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu sem tristique habitant tincidunt mauris ipsum ullamcorper. Facilisis id tellus nunc eu lectus. Euismod mi purus posuere scelerisque porta. Est, at cursus libero augue sed.",
      schedules: {
        "Monday": "Fermé",
        "Tuesday": "10h00 - 12h00 / 14h00 - 19h00",
        "Wednesday": "10h00 - 12h00",
        "Thursday": "10h00 - 12h00 / 14h00 - 19h00",
        "Friday": "10h00 - 12h00 / 14h00 - 19h00",
        "Saturday": "10h00 - 12h00 / 14h00 - 19h00",
        "Sunday": "Fermé"
      },
      address: "10 Rue Derval, Rennes, 35000",
      phoneNumber: "01 02 03 04 05",
      emailAddress: "info@moncommerce.fr"
    );

    state = state.copyWith(commerce: AsyncValue.data(demo));
  }
}
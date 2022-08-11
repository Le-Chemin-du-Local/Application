import 'package:chemin_du_local/features/storekeepers/services/models/service_basket_state/services_basket_state.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final servicesBasketControllerProvider = StateNotifierProvider<ServicesBasketController, ServicesBasketState>((ref) {
  return ServicesBasketController(
    const ServicesBasketState(services: [])
  );
});

class ServicesBasketController extends StateController<ServicesBasketState> {
  ServicesBasketController(ServicesBasketState state) : super(state);

  void addServiceInfo(ServiceInfo info, ServiceType type) {
    state = state.copyWith(
      services: [
        for (final service in state.services)
          service,
        Tuple2(info, type)
      ]
    );
  }

  void removeServiceInfo(ServiceInfo info) {
    state = state.copyWith(
      services: [
        for (final service in state.services)
          if (service.item1.id != info.id)
            service
      ]
    );
  }

  void replaceServiceInfoType(ServiceInfo info, ServiceType type) {
    state = state.copyWith(
      services: [
        for (final service in state.services)
          if (service.item1.id == info.id)
            Tuple2(info, type)
          else 
            service
      ]
    );
  }

  void clear() {
    state = state.copyWith(services: []);
  }
}
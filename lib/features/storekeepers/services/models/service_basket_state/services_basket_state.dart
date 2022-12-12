import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tuple/tuple.dart';

part 'services_basket_state.freezed.dart';

@freezed
@immutable
class ServicesBasketState with _$ServicesBasketState {
  const ServicesBasketState._();

  const factory ServicesBasketState({
    required List<Tuple2<ServiceInfo, ServiceType>> services
  }) = _ServicesBasketState;


  bool containsService(ServiceInfo info) {
    for (final service in services) {
      if (service.item1.id == info.id) return true;
    }

    return false;
  }

  ServiceType? typeForService(ServiceInfo info) {
    for (final service in services) {
      if (service.item1.id == info.id) {
        return service.item2;
      }
    }

    return null;
  }
}
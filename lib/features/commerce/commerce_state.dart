import 'package:chemin_du_local/features/commerce/commerce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class CommerceState {
  const CommerceState({
    required this.commerce
  });

  final AsyncValue<Commerce?> commerce;

  CommerceState copyWith({
    AsyncValue<Commerce?>? commerce
  }) {
    return CommerceState(commerce: commerce ?? this.commerce);
  }
}
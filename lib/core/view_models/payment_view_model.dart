import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/enums/payments_enum.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:ruminate/core/key_value_storage/providers/key_value_storage_provider.dart';

class PaymentViewModel extends StateNotifier<AsyncValue<bool>> {
  final KeyValueStorage keyValueStorage;
  List<Map<String, bool>>? _cachedPayments = [];
  PaymentViewModel({required this.keyValueStorage})
    : super(const AsyncValue.loading()) {
    checkPayments();
  }

  Future<void> pay(PaymentsEnum payment) async {
    state = AsyncValue.loading();

    // Payment service imitation
    await Future.delayed(Duration(seconds: 3));

    await keyValueStorage.writeBool(payment.name, true);

    _cachedPayments = null;

    state = AsyncData(true);
  }

  FutureOr<List<Map<String, bool?>>> checkPayments() async {
    state = AsyncValue.loading();

    if (_cachedPayments == null) {
      List<Map<String, bool>> paymentsList = [];

      for (int i = 0; i < PaymentsEnum.values.length; i++) {
        final paymentEnum = PaymentsEnum.values[i];

        final paymentValue =
            await keyValueStorage.readValue<bool>(paymentEnum.name) ?? false;

        final paymentMap = {paymentEnum.name: paymentValue};

        paymentsList.add(paymentMap);
      }


    _cachedPayments = paymentsList;
    }


    state = AsyncValue.data(true);

    return _cachedPayments!;
  }
}

final paymentViewModel =
    StateNotifierProvider<PaymentViewModel, AsyncValue<bool>>(
      (ref) =>
          PaymentViewModel(keyValueStorage: ref.watch(keyValueStorageProvider)),
    );

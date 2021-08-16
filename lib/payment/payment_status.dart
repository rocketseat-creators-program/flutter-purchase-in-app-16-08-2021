import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

enum PaymentType { empty, loading, success, error }

class PaymentStatus {
  final PaymentType type;
  final String? error;
  final PurchasedItem? item;
  PaymentStatus({
    required this.type,
    this.error,
    this.item,
  });

  PaymentStatus.empty()
      : this.type = PaymentType.empty,
        this.error = null,
        this.item = null;

  PaymentStatus.loading()
      : this.type = PaymentType.loading,
        this.error = null,
        this.item = null;

  PaymentStatus.success(this.item)
      : this.type = PaymentType.success,
        this.error = null;

  PaymentStatus.error(this.error)
      : this.type = PaymentType.error,
        this.item = null;
}

extension PaymentStatusExt on PaymentStatus {
  dynamic when({
    required dynamic Function() orElse,
    dynamic Function()? empty,
    dynamic Function()? loading,
    dynamic Function(PurchasedItem item)? success,
    dynamic Function(String message)? error,
  }) {
    switch (this.type) {
      case PaymentType.empty:
        {
          if (empty == null) {
            return orElse();
          }
          return empty();
        }
      case PaymentType.loading:
        {
          if (loading == null) {
            return orElse();
          }
          return loading();
        }
      case PaymentType.success:
        {
          if (success == null) {
            return orElse();
          }
          return success(this.item!);
        }

      case PaymentType.error:
        {
          if (error == null) {
            return orElse();
          }
          return error(this.error!);
        }

      default:
        throw "INVALID PAYMENT TYPE";
    }
  }
}

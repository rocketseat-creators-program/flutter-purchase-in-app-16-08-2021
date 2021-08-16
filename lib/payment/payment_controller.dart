import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import 'payment_status.dart';

export 'payment_status.dart';

abstract class PaymentController {
  void dispose();
  Future<bool> connect();
  Future<bool> disconnect();
  Future<List<IAPItem>> getItems(List<String> skus);
  Future<bool> purchaseItem(String productId);
  void listen(Function(PaymentStatus status) listener);
}

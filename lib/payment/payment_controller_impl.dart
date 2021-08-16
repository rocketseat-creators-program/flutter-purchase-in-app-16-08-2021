import 'dart:async';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import 'payment_controller.dart';
import 'payment_status.dart';

class PaymentControllerImpl implements PaymentController {
  StreamSubscription? _subscriptionError;
  StreamSubscription? _subscriptionUpdated;
  @override
  Future<bool> connect() async {
    FlutterInappPurchase.instance.initConnection;
    bool response = false;
    await for (var stream in FlutterInappPurchase.connectionUpdated) {
      if (stream.connected == true) {
        response = true;
        break;
      } else {
        break;
      }
    }
    return response;
  }

  @override
  Future<bool> disconnect() async {
    FlutterInappPurchase.instance.endConnection;
    bool response = false;
    await for (var stream in FlutterInappPurchase.connectionUpdated) {
      if (stream.connected == true) {
        response = true;
        break;
      } else {
        break;
      }
    }
    return response;
  }

  @override
  Future<List<IAPItem>> getItems(List<String> skus) {
    return FlutterInappPurchase.instance.getProducts(skus);
  }

  @override
  void listen(Function(PaymentStatus status) listener) {
    _subscriptionError = FlutterInappPurchase.purchaseError.listen((event) {
      listener(PaymentStatus.error(event!.message));
    });
    _subscriptionUpdated = FlutterInappPurchase.purchaseUpdated.listen((event) {
      listener(PaymentStatus.success(event));
    });
  }

  @override
  Future<bool> purchaseItem(String productId) async {
    try {
      FlutterInappPurchase.instance.requestPurchase(productId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _subscriptionError?.cancel();
    _subscriptionUpdated?.cancel();
  }
}

import 'package:flutter/material.dart';
import 'package:purchaseinapp/payment/payment_controller.dart';
import 'home_status.dart';

export 'home_status.dart';

class HomeController extends ChangeNotifier {
  final PaymentController controller;
  HomeController({
    required this.controller,
  });
  HomeStatus status = HomeStatus.empty();

  void update(HomeStatus status) {
    this.status = status;
    notifyListeners();
  }

  Future<void> connectPayment() async {
    update(HomeStatus.connecting());
    final response = await this.controller.connect();
    update(response ? HomeStatus.connected() : HomeStatus.disconnected());
  }

  Future<void> disconnectPayment() async {
    await this.controller.disconnect();
    update(HomeStatus.disconnected());
  }

  Future<void> getProducts() async {
    try {
      update(HomeStatus.loading());
      final response = await this.controller.getItems(["a"]);
      update(HomeStatus.products(response));
    } catch (e) {
      update(HomeStatus.error(e.toString()));
    }
  }

  Future<void> requestPayment(String sku) async {
    listenPayment();
    await controller.purchaseItem(sku);
  }

  void listenPayment() {
    controller.listen((status) {
      final homeStatus = status.when(
        success: (item) => HomeStatus.paymentSuccess(item),
        error: (message) => HomeStatus.paymentError(message),
        loading: () => HomeStatus.paymentLoading(),
        orElse: () => HomeStatus.empty(),
      );
      update(homeStatus);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:purchaseinapp/home/home_controller.dart';
import 'package:purchaseinapp/payment/payment_controller_impl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController(controller: PaymentControllerImpl());

  @override
  void initState() {
    controller.connectPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget hasConnected() => Column(
          children: [
            Text("Status payment: "),
            TextButton(
                onPressed: () {
                  controller.getProducts();
                },
                child: Text("Buscar produtos")),
          ],
        );

    Widget hasDisconnected() => Center(
          child: Text("OPS! Sem conexão"),
        );

    Widget hasProducts(List<IAPItem> items) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(items[index].title ?? ""),
              subtitle: Text(items[index].price ?? ""),
              onTap: () {
                controller.requestPayment(items[index].productId!);
              },
            ));
    Widget hasError(String message) => Center(
          child: Text("ERROR: $message"),
        );

    return Scaffold(
        appBar: AppBar(
          title: Text("Payment in APP"),
        ),
        body: AnimatedBuilder(
            animation: controller,
            builder: (_, __) => controller.status.when<Widget>(
                connected: () => hasConnected(),
                disconnected: () => hasDisconnected(),
                products: (items) => hasProducts(items),
                error: (message) => hasError(message),
                paymentError: (message) => hasError(message),
                orElse: () => Center(
                      child: CircularProgressIndicator(),
                    ))));
  }
}

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

enum HomeType {
  empty,
  connecting,
  connected,
  disconnected,
  loading,
  products,
  error,
  paymentSuccess,
  paymentLoading,
  paymentError,
}

class HomeStatus {
  final HomeType type;
  final String? error;
  final PurchasedItem? item;
  final List<IAPItem>? products;
  HomeStatus({
    required this.type,
    this.error,
    this.item,
    this.products,
  });

  HomeStatus.empty()
      : this.type = HomeType.empty,
        this.error = null,
        this.products = null,
        this.item = null;

  HomeStatus.loading()
      : this.type = HomeType.loading,
        this.error = null,
        this.products = null,
        this.item = null;

  HomeStatus.products(this.products)
      : this.type = HomeType.products,
        this.error = null,
        this.item = null;

  HomeStatus.error(this.error)
      : this.type = HomeType.error,
        this.products = null,
        this.item = null;

  HomeStatus.connecting()
      : this.type = HomeType.connecting,
        this.error = null,
        this.products = null,
        this.item = null;
  HomeStatus.connected()
      : this.type = HomeType.connected,
        this.error = null,
        this.products = null,
        this.item = null;
  HomeStatus.disconnected()
      : this.type = HomeType.disconnected,
        this.error = null,
        this.products = null,
        this.item = null;

  HomeStatus.paymentSuccess(this.item)
      : this.type = HomeType.paymentSuccess,
        this.products = null,
        this.error = null;
  HomeStatus.paymentLoading()
      : this.type = HomeType.paymentLoading,
        this.item = null,
        this.products = null,
        this.error = null;

  HomeStatus.paymentError(this.error)
      : this.type = HomeType.paymentError,
        this.products = null,
        this.item = null;
}

extension HomeStatusExt on HomeStatus {
  T when<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? loading,
    T Function(List<IAPItem>)? products,
    T Function(String message)? error,
    T Function()? connecting,
    T Function()? connected,
    T Function()? disconnected,
    T Function(PurchasedItem item)? paymentSuccess,
    T Function()? paymentLoading,
    T Function(String message)? paymentError,
  }) {
    switch (this.type) {
      case HomeType.empty:
        {
          if (empty == null) {
            return orElse();
          }
          return empty();
        }
      case HomeType.loading:
        {
          if (loading == null) {
            return orElse();
          }
          return loading();
        }
      case HomeType.products:
        {
          if (products == null) {
            return orElse();
          }
          return products(this.products!);
        }
      case HomeType.error:
        {
          if (error == null) {
            return orElse();
          }
          return error(this.error!);
        }
      case HomeType.connecting:
        {
          if (connecting == null) {
            return orElse();
          }
          return connecting();
        }
      case HomeType.connected:
        {
          if (connected == null) {
            return orElse();
          }
          return connected();
        }
      case HomeType.disconnected:
        {
          if (disconnected == null) {
            return orElse();
          }
          return disconnected();
        }
      case HomeType.paymentSuccess:
        {
          if (paymentSuccess == null) {
            return orElse();
          }
          return paymentSuccess(this.item!);
        }

      case HomeType.paymentLoading:
        {
          if (paymentLoading == null) {
            return orElse();
          }
          return paymentLoading();
        }

      case HomeType.paymentError:
        {
          if (paymentError == null) {
            return orElse();
          }
          return paymentError(this.error!);
        }

      default:
        throw "INVALID Home TYPE";
    }
  }
}

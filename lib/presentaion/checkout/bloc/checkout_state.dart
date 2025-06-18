abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class ShippingMethodSelectedState extends CheckoutState {
  final bool isHomedelivery;

  ShippingMethodSelectedState({required this.isHomedelivery});
}

class PaymentCardSelectedState extends CheckoutState {
  final int index;

  PaymentCardSelectedState({required this.index});
}

class OtherPaymentMethodSelectedState extends CheckoutState {
  final String method;

  OtherPaymentMethodSelectedState({required this.method});
}

class PurchaseButtonPressedState extends CheckoutState {
  final String name;
  final String imageUrl;
  final double price;

  PurchaseButtonPressedState({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

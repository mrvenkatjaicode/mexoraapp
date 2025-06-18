abstract class CheckoutEvent {}

class SelectShippingMethodEvent extends CheckoutEvent {
  final bool isHomedelivery;

  SelectShippingMethodEvent({required this.isHomedelivery});
}

class SelectPaymentCardEvent extends CheckoutEvent {
  final int index;

  SelectPaymentCardEvent({required this.index});
}

class SelectOtherPaymentMethodEvent extends CheckoutEvent {
  final String method;

  SelectOtherPaymentMethodEvent({required this.method});
}

class PurchaseButtonPressedEvent extends CheckoutEvent {
  final String name;
  final String imageUrl;
  final double price;

  PurchaseButtonPressedEvent({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

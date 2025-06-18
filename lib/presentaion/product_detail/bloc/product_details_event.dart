abstract class ProductDetailsEvent {}

class AddtoFavEvent extends ProductDetailsEvent {
  final Map<String, dynamic> product;

  AddtoFavEvent({required this.product});
}

class SelectVarientEvent extends ProductDetailsEvent {
  final int index;

  SelectVarientEvent(this.index);
}

class ChangeColorEvent extends ProductDetailsEvent {
  final int index;

  ChangeColorEvent(this.index);
}

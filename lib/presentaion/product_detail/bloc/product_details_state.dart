abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class AddedToFavSuccessState extends ProductDetailsState {
  final Map<String, dynamic> product;

  AddedToFavSuccessState({required this.product});
}

class SelectedVarientState extends ProductDetailsState {
  final int index;

  SelectedVarientState({required this.index});
}

class ProductDetailsColorChanged extends ProductDetailsState {
  final int index;

  ProductDetailsColorChanged({required this.index});
}

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class ProductNameSelectedState extends HomeState {
  final int productIndex;

  ProductNameSelectedState({required this.productIndex});
}

class AddedToFavState extends HomeState {
  final Map<String, dynamic> item;

  AddedToFavState({required this.item});
}

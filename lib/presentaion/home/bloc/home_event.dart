abstract class HomeEvent {}

class OnSelectProductNameEvent extends HomeEvent {
  final int index;

  OnSelectProductNameEvent({required this.index});
}

class AddToFavEvent extends HomeEvent {
  final Map<String, dynamic> item;

  AddToFavEvent({required this.item});
}

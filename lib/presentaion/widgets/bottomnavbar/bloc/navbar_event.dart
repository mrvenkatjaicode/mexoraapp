abstract class NavbarEvent {}

class OnSelectNavbarEvent extends NavbarEvent {
  final int index;

  OnSelectNavbarEvent({required this.index});
}
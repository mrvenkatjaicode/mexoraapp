abstract class NavbarState {}

class NavbarInitialState extends NavbarState {}

class NavbarLoadingState extends NavbarState {}

class NavbarSelectedState extends NavbarState {
  final int selectedIndex;

  NavbarSelectedState({required this.selectedIndex});
}

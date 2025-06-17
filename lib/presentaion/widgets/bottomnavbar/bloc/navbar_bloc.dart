import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/widgets/bottomnavbar/bloc/navbar_event.dart';
import 'package:mexoraapp/presentaion/widgets/bottomnavbar/bloc/navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitialState()) {
    on<OnSelectNavbarEvent>(selectbottombar);
  }

  selectbottombar(OnSelectNavbarEvent event, Emitter<NavbarState> emit) {
    emit(NavbarLoadingState());
    emit(NavbarSelectedState(selectedIndex: event.index));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_event.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<OnSelectProductNameEvent>(selectproductnamefunction);
    on<AddToFavEvent>(addtofavfunction);
  }

  selectproductnamefunction(
    OnSelectProductNameEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeLoadingState());
    emit(ProductNameSelectedState(productIndex: event.index));
  }

  addtofavfunction(AddToFavEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(AddedToFavState(item: event.item));
  }
}

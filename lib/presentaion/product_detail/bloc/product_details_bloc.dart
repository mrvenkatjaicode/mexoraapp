import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/product_detail/bloc/product_details_event.dart';
import 'package:mexoraapp/presentaion/product_detail/bloc/product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<SelectVarientEvent>(clickchangevarientfunction);
    on<ChangeColorEvent>(clickchangecolorfunction);
    on<AddtoFavEvent>(addtofavfunction);
  }

  addtofavfunction(AddtoFavEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsLoading());
    emit(AddedToFavSuccessState(product: event.product));
  }

  clickchangevarientfunction(
    SelectVarientEvent event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(ProductDetailsLoading());
    emit(SelectedVarientState(index: event.index));
  }

  clickchangecolorfunction(
    ChangeColorEvent event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(ProductDetailsLoading());
    emit(ProductDetailsColorChanged(index: event.index));
  }
}

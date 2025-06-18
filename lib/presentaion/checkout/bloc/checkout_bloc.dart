import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/checkout/bloc/checkout_event.dart';
import 'package:mexoraapp/presentaion/checkout/bloc/checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<SelectShippingMethodEvent>(selectshippingmethod);
    on<SelectPaymentCardEvent>(selectpaymetnmethod);
    on<SelectOtherPaymentMethodEvent>(selectotherpaymentmethod);
    on<PurchaseButtonPressedEvent>(purchasebuttonpressed);
  }

  selectshippingmethod(
    SelectShippingMethodEvent event,
    Emitter<CheckoutState> emit,
  ) {
    emit(CheckoutLoadingState());
    emit(ShippingMethodSelectedState(isHomedelivery: event.isHomedelivery));
  }

  selectpaymetnmethod(
    SelectPaymentCardEvent event,
    Emitter<CheckoutState> emit,
  ) {
    emit(CheckoutLoadingState());
    emit(PaymentCardSelectedState(index: event.index));
  }

  selectotherpaymentmethod(
    SelectOtherPaymentMethodEvent event,
    Emitter<CheckoutState> emit,
  ) {
    emit(CheckoutLoadingState());
    emit(OtherPaymentMethodSelectedState(method: event.method));
  }

  purchasebuttonpressed(
    PurchaseButtonPressedEvent event,
    Emitter<CheckoutState> emit,
  ) {
    emit(CheckoutLoadingState());
    emit(
      PurchaseButtonPressedState(
        name: event.name,
        imageUrl: event.imageUrl,
        price: event.price,
      ),
    );
  }
}

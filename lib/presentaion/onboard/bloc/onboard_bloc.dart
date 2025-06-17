import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mexoraapp/presentaion/onboard/bloc/onboard_event.dart';
import 'package:mexoraapp/presentaion/onboard/bloc/onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  OnboardBloc() : super(OnboardInitialState()) {
    on<OnNavigateSkipEvent>(onpressedSkip);
    on<OnNavigateLogInEvent>(onpressedLogin);
  }

  bool isLoadingSkip = false;
  bool isLoadingLogIn = false;

  Future<void> onpressedSkip(
    OnNavigateSkipEvent event,
    Emitter<OnboardState> emit,
  ) async {
    emit(OnboardLoadingState());
    isLoadingSkip = true;

    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));

    // Set onboarding completed flag
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    emit(NavigateSuccessState());
  }

  Future<void> onpressedLogin(
    OnNavigateLogInEvent event,
    Emitter<OnboardState> emit,
  ) async {
    emit(OnboardLoadingState());
    isLoadingLogIn = true;

    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    emit(NavigateSuccessState());
  }
}
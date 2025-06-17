import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/core/constants.dart';
import 'package:mexoraapp/presentaion/home/pages/home_screen.dart';
import 'package:mexoraapp/presentaion/onboard/bloc/onboard_bloc.dart';
import 'package:mexoraapp/presentaion/onboard/bloc/onboard_event.dart';
import 'package:mexoraapp/presentaion/onboard/bloc/onboard_state.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardBloc(),
      child: BlocConsumer<OnboardBloc, OnboardState>(
        listener: (context, state) {
          if (state is NavigateSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
            context.read<OnboardBloc>().isLoadingSkip = false;
            context.read<OnboardBloc>().isLoadingLogIn = false;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onboardImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: context.read<OnboardBloc>().isLoadingSkip
                          ? 50
                          : MediaQuery.of(context).size.width,
                      height: 50,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: GestureDetector(
                        onTap: context.read<OnboardBloc>().isLoadingSkip
                            ? null
                            : () {
                                context.read<OnboardBloc>().add(
                                  OnNavigateSkipEvent(),
                                );
                              },
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: context.read<OnboardBloc>().isLoadingSkip
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: context.read<OnboardBloc>().isLoadingLogIn
                          ? 50
                          : MediaQuery.of(context).size.width,
                      height: 50,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Color(0xFF03C27E),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: GestureDetector(
                        onTap: context.read<OnboardBloc>().isLoadingLogIn
                            ? null
                            : () {
                                context.read<OnboardBloc>().add(
                                  OnNavigateLogInEvent(),
                                );
                              },
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: context.read<OnboardBloc>().isLoadingLogIn
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mexoraapp/presentaion/home/pages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mexoraapp/presentaion/onboard/pages/onboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/onboard/bloc/onboard_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('onboarding_completed') ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mexora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<bool>(
        future: isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final showOnboarding = snapshot.data ?? true;

          return BlocProvider(
            create: (_) => OnboardBloc(),
            child: showOnboarding ? const OnboardScreen() : const HomeScreen(),
          );
        },
      ),
    );
  }
}

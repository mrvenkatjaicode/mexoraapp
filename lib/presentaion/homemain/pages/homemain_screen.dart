import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/cart/pages/cart_screen.dart';
import 'package:mexoraapp/presentaion/favorites/pages/fav_screen.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_bloc.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_event.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_state.dart';
import 'package:mexoraapp/presentaion/home/pages/home_screen.dart';
import 'package:mexoraapp/presentaion/profile/pages/profile_screen.dart';

class HomemainScreen extends StatelessWidget {
  const HomemainScreen({super.key});

  static int currentIndex = 0;

  static List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    FavScreen(),
    ProfileScreen(),
  ];

  static List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.shopping_bag_outlined, 'label': 'Shop'},
    {'icon': Icons.favorite_border, 'label': 'Favorites'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is ProductNameSelectedState) {
            currentIndex = state.productIndex;
          } else if (state is StoreInSharePreferencesSuccessState) {
            debugPrint(state.item.length.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: currentIndex == 1 || currentIndex == 2 || currentIndex == 3
                ? AppBar(
                    backgroundColor: Colors.white,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          context.read<HomeBloc>().add(
                            OnSelectProductNameEvent(index: 0),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),

                    elevation: 0,
                    title: currentIndex == 1
                        ? Text("Cart")
                        : currentIndex == 2
                        ? Text("Favorites")
                        : Text("Profile"),
                  )
                : null,
            body: screens[currentIndex],
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(navItems.length, (index) {
                    final isSelected = currentIndex == index;
                    final item = navItems[index];

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE9FFF2) : null,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          context.read<HomeBloc>().add(
                            OnSelectProductNameEvent(index: index),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              item['icon'],
                              color: isSelected ? Colors.green : Colors.grey,
                              size: 24,
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              child: isSelected
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(
                                        item['label'],
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/widgets/bottomnavbar/bloc/navbar_bloc.dart';
import 'package:mexoraapp/presentaion/widgets/bottomnavbar/bloc/navbar_event.dart';
import 'package:mexoraapp/presentaion/widgets/bottomnavbar/bloc/navbar_state.dart';

class AnimatedBottomNavBarWidger extends StatelessWidget {
  const AnimatedBottomNavBarWidger({super.key});

  static int selectedIndex = 0;

  static List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.shopping_bag_outlined, 'label': 'Shop'},
    {'icon': Icons.favorite_border, 'label': 'Favorites'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarBloc(),
      child: BlocConsumer<NavbarBloc, NavbarState>(
        listener: (context, state) {
          if (state is NavbarSelectedState) {
            selectedIndex = state.selectedIndex;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(navItems.length, (index) {
                  final isSelected = selectedIndex == index;
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
                        context.read<NavbarBloc>().add(
                          OnSelectNavbarEvent(index: index),
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
          );
        },
      ),
    );
  }
}

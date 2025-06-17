import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/core/constants.dart';
import 'package:mexoraapp/data/mock.dart';
import 'package:mexoraapp/features/product_detail_screen.dart';
import 'package:mexoraapp/presentaion/widgets/bottomnavbar/pages/animated_bottom_nav_bar_widger.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_bloc.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_event.dart';
import 'package:mexoraapp/presentaion/home/bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static List<String> categories = [
    'Technology',
    'Fashion',
    'Sports',
    'Supermarket',
    'Toys',
    'Home',
  ];

  static int selectedIndex = 0;

  static PageController pageController = PageController(viewportFraction: 0.6);
  static int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is ProductNameSelectedState) {
            selectedIndex = state.productIndex;
          } else if (state is AddedToFavState) {
            state.item['isFavorite'] = !state.item['isFavorite'];
          }
        },
        builder: (context, state) {
          if (state is HomeInitialState) {
            pageController.addListener(() {
              final newPage = pageController.page?.round() ?? 0;
              if (newPage != currentPage) {
                currentPage = newPage;
              }
            });
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Search products',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Color(0xFFF7F7F7),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),

                          Stack(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F7F7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notifications_none,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Positioned(
                                top: 3,
                                right: -2,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.asset(bannerImage),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final isSelected = selectedIndex == index;
                            return GestureDetector(
                              onTap: () {
                                context.read<HomeBloc>().add(
                                  OnSelectProductNameEvent(index: index),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hot sales",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              hotsales.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                ),
                                width: index == 0 ? 20 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? Colors.green
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: hotsales.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final product = hotsales[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: product['id'],
                                    child: Image.asset(
                                      product["image"],
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    product["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${product["currency"]} ${product["price"]}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE9FFF2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      product["shipping"],
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Text(
                            "Recently viewed",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: recentlyViewed.length,
                            itemBuilder: (context, index) {
                              final item = recentlyViewed[index];
                              return Container(
                                width: 180,
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9FFF2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            item['image'],
                                            height: 100,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          item['name'],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "\$ ${item['price'].toString()}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          context.read<HomeBloc>().add(
                                            AddToFavEvent(item: item),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.favorite,
                                            size: 20,
                                            color: item['isFavorite']
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: AnimatedBottomNavBarWidger(),
          );
        },
      ),
    );
  }
}

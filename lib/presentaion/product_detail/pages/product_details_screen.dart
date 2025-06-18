import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mexoraapp/presentaion/checkout/pages/checkout_screen.dart';
import 'package:mexoraapp/presentaion/product_detail/bloc/product_details_bloc.dart';
import 'package:mexoraapp/presentaion/product_detail/bloc/product_details_event.dart';
import 'package:mexoraapp/presentaion/product_detail/bloc/product_details_state.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  static int selectedVariant = 0;
  static int selectedIndex = 0;

  static List<Color> colors = [
    Color(0xFF3B3D3C),
    Color(0xCDC5BCAD),
    Color(0xFFD1D1D1),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsBloc(),
      child: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
        listener: (context, state) {
          if (state is SelectedVarientState) {
            selectedVariant = state.index;
          } else if (state is AddedToFavSuccessState) {
            state.product['isFavorite'] = !state.product['isFavorite'];
          } else if (state is ProductDetailsColorChanged) {
            selectedIndex = state.index;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.read<ProductDetailsBloc>().add(
                        AddtoFavEvent(product: product),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        shape: BoxShape.circle,
                      ),
                      child: product['isFavorite']
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share_outlined),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Hero(
                  tag: product['id'],
                  child: Image.asset(product['image'], height: 200),
                ),
                const SizedBox(height: 8),
                // Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(product['variants'].length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                       decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                // Variant thumbnails
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(product['variants'].length, (index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ProductDetailsBloc>().add(
                          SelectVarientEvent(index),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedVariant == index
                                ? Color(0xFF03C27E)
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          product['variants'][index],
                          height: 40,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                // Product Name and Price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        spacing: 8,
                        children: [
                          Text(
                            "\$ ${product['price']}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(width: 1, height: 15, color: Colors.grey),
                          const Text(
                            "Including taxes and duties",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      // Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(colors.length, (index) {
                              bool isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  context.read<ProductDetailsBloc>().add(
                                    ChangeColorEvent(index),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  width: 30,
                                  height: 30,
                                  child: isSelected
                                      ? Container(
                                          padding: EdgeInsets.all(
                                            3,
                                          ), 
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colors[index],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colors[index],
                                          ),
                                        ),
                                ),
                              );
                            }),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              Text(
                                "${product['rating']} ",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "(${product['reviews']})",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          showTopSnackBar(
                            Overlay.of(context),
                            onTap: () {},
                            CustomSnackBar.success(
                              message: '${product['name']} added to cart',
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: Color(0xFF03C27E),
                            ),

                            dismissType: DismissType.onSwipe,
                            dismissDirection: [DismissDirection.endToStart],
                          );
                        },
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF03C27E),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                name: product['name'],
                                price: product['price'].toDouble(),
                                imageUrl: product['image'],
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mexoraapp/features/checkout_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedVariant = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
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
                width: selectedVariant == index ? 10 : 6,
                height: selectedVariant == index ? 10 : 6,
                decoration: BoxDecoration(
                  color: selectedVariant == index ? Colors.green : Colors.grey,
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
                onTap: () => setState(() => selectedVariant = index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedVariant == index
                          ? Colors.green
                          : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(product['variants'][index], height: 40),
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
                Text(
                  "\$ ${product['price']}",
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                const Text(
                  "Including taxes and duties",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                // Rating
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(
                      "${product['rating']} (${product['reviews']})",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  onPressed: () {},
                  child: const Text("Add to cart"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
                  child: const Text("Buy Now"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

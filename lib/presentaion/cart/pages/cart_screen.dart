import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cart is empty',
        style: TextStyle(fontSize: 24, color: Colors.grey[700]),
      ),
    );
  }
}

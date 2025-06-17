import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double price;

  const CheckoutScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool homeDelivery = true;
  int selectedCard = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productSummary(),
            const SizedBox(height: 24),
            _shippingMethod(),
            const SizedBox(height: 24),
            const Text("Select your payment method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _paymentCards(),
            const SizedBox(height: 16),
            _otherPaymentMethods(),
            const SizedBox(height: 16),
            _priceSummary(),
            const SizedBox(height: 24),
            _finalButton(),
          ],
        ),
      ),
    );
  }

  Widget _productSummary() {
    return Row(
      children: [
        Image.asset(widget.imageUrl, width: 60, height: 60),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("\$${widget.price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.green, fontSize: 16)),
              const Text("Including taxes and duties", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        )
      ],
    );
  }

  Widget _shippingMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Shipping method", style: TextStyle(fontSize: 14)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: [
              _toggleButton("Home delivery", homeDelivery, () {
                setState(() {
                  homeDelivery = true;
                });
              }),
              _toggleButton("Pick up in store", !homeDelivery, () {
                setState(() {
                  homeDelivery = false;
                });
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toggleButton(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: selected ? Colors.white : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentCards() {
    final cards = [
      {'number': '**** **** **** 1921', 'date': '07/25'},
      {'number': '**** **** **** 5632', 'date': '07/25'},
    ];

    return Row(
      children: List.generate(cards.length, (index) {
        final isSelected = index == selectedCard;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => selectedCard = index);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    if (index == 0) Colors.green.shade800 else Colors.teal.shade300,
                    Colors.greenAccent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("VISA", style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 20),
                  Text(cards[index]['number']!, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(cards[index]['date']!, style: const TextStyle(color: Colors.white)),
                  if (isSelected)
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.check_circle, color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _otherPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("+ Add new", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _paymentIcon("GPay", Icons.payments),
            _paymentIcon("Apple", Icons.phone_iphone),
            _paymentIcon("PayPal", Icons.account_balance_wallet),
          ],
        ),
      ],
    );
  }

  Widget _paymentIcon(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }

  Widget _priceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(thickness: 1),
        _priceRow("Subtotal (2 items)", widget.price),
        _priceRow("Shipping cost", 0),
        const Divider(thickness: 1),
        _priceRow("Total", widget.price, isBold: true),
      ],
    );
  }

  Widget _priceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _finalButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Purchase finalized!")),
          );
        },
        child: const Text("Finalize Purchase", style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
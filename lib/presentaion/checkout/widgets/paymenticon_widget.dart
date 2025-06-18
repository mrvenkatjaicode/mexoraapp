
import 'package:flutter/material.dart';

Widget paymentIcon(String label, bool isSelected, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: isSelected ? Colors.green.shade100 : null,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [Icon(icon, size: 18), const SizedBox(width: 4), Text(label)],
    ),
  );
}

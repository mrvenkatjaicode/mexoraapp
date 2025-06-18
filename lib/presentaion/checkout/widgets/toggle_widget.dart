
import 'package:flutter/material.dart';

Widget toggleButton(String text, bool selected, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            selected
                ? BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                : BoxShadow(color: Colors.transparent),
          ],
          color: selected ? Colors.white : null,
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

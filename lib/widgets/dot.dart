import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final bool active;

  Dot({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.black : Colors.grey, // Warna hitam jika active, abu-abu jika tidak
      ),
    );
  }
}
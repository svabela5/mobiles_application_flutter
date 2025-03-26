import 'package:flutter/material.dart';

class InfoLine extends StatelessWidget {
  final String boldText;
  final String normalText;

  const InfoLine({required this.boldText, required this.normalText, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          boldText,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 40),
        Text(
          normalText,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobiles_application_flutter/models/phone.dart';
import 'package:mobiles_application_flutter/widgets/info_line.dart';

class PhoneInfo extends StatelessWidget {
  final Phone phone;
  final Function() goBackToMainScreen;

  const PhoneInfo({super.key, required this.phone, required this.goBackToMainScreen});

  

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,  // Aligns text to the right
        children: [
          InfoLine(boldText: 'Phone:', normalText: '${phone.brand} ${phone.model}'),
          const SizedBox(height: 10),
          InfoLine(boldText: 'Price:', normalText: '€${phone.price}'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: goBackToMainScreen,
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}

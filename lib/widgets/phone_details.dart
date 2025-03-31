import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobiles_application_flutter/models/phone.dart';
import 'package:mobiles_application_flutter/widgets/info_line.dart';

class PhoneInfo extends StatelessWidget {
  final Phone phone;
  final Function() goBackToMainScreen;

  const PhoneInfo({super.key, required this.phone, required this.goBackToMainScreen});

  

   @override
  Widget build(BuildContext context) {
  File? _selectedImage = null;

  if(phone.image != '') {
    String outputPath = '/storage/emulated/0/Download/${phone.brand}_${phone.model}.jpg';
    File outputFile = File(outputPath);
    List<int> imageBytes = base64Decode(phone.image);
    outputFile.writeAsBytesSync(imageBytes); // Synchronous write
    _selectedImage = outputFile;
  } else {
    _selectedImage = null;
  }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,  // Aligns text to the right
        children: [
          InfoLine(boldText: 'Phone:', normalText: '${phone.brand} ${phone.model}'),
          const SizedBox(height: 10),
          InfoLine(boldText: 'Price:', normalText: '€${phone.price}'),
          const SizedBox(height: 10),
          const SizedBox(
            height: 20,
          ),
          _selectedImage == null
              ? const Text("No Image Selected")
              : Image.file(_selectedImage!),
          ElevatedButton(
            onPressed: goBackToMainScreen,
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}

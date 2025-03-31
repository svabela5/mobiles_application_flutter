import 'package:flutter/material.dart';

class ImageButtons extends StatelessWidget {
  final Function() galleryFunction;
  final Function() cameraFunction;

  const ImageButtons({super.key, required this.galleryFunction, required this.cameraFunction});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Small screens (stacked vertically)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity, // Makes button full width
                  child: buildButton("Pick Image from Gallery", Colors.blue, galleryFunction),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // Makes button full width
                  child: buildButton("Pick Image from Camera", Colors.red, cameraFunction),
                ),
              ],
            );
          } else {
            // Medium & Large screens (side by side)
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: buildButton("Pick Image from Gallery", Colors.blue, galleryFunction)),
                const SizedBox(width: 10),
                Expanded(child: buildButton("Pick Image from Camera", Colors.red, cameraFunction)),
              ],
            );
          }
        },
      );
  }

  //returns a button used to simplify the code and make it more readable
  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      padding: EdgeInsets.symmetric(vertical: 15), // Make buttons taller
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  void _pickImageFromGallery() {
    print("Gallery button pressed");
  }

  void _pickImageFromCamera() {
    print("Camera button pressed");
  }
}

import 'package:flutter/material.dart';

class PhoneList extends StatefulWidget {
  const PhoneList({super.key});

  @override
  State<PhoneList> createState() => _PhoneList();
}

class _PhoneList extends State<PhoneList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Arena'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Phone $index'),
            subtitle: Text('Description of Phone $index'),
            leading: const Icon(Icons.phone_android),
            trailing: Text(
                '€${index * 100}',
              ),
            onTap: () {
              // Navigate to the phone details page
            },
          );
        },
      ),
    );
  }
}
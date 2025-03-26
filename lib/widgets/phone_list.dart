import 'package:flutter/material.dart';
import 'package:mobiles_application_flutter/Data/dummy_data.dart';
import 'package:mobiles_application_flutter/models/phone.dart';

class PhoneList extends StatefulWidget {
  const PhoneList({super.key});

  @override
  State<PhoneList> createState() => _PhoneList();
}

class _PhoneList extends State<PhoneList> {
  List<Phone> _phones = [];

  @override
  void initState() {
    _phones = dummyPhones;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Arena'),
      ),
      body: ListView.builder(
        itemCount: _phones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_phones[index].brand),
            subtitle: Text(_phones[index].model),
            leading: const Icon(Icons.phone_android),
            trailing: Text(
                '€${_phones[index].price}',
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
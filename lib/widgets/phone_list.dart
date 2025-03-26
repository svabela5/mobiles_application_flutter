import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobiles_application_flutter/models/phone.dart';
import 'package:mobiles_application_flutter/widgets/new_phone.dart';
import 'package:http/http.dart' as http;

class PhoneList extends StatefulWidget {
  const PhoneList({super.key});

  @override
  State<PhoneList> createState() => _PhoneList();
}

class _PhoneList extends State<PhoneList> {
  List<Phone> _phones = [];

  @override
  void initState() {
    super.initState();
    _loadPhones();
  }

  Future _loadPhones() async {

    try {
      final url = Uri.https('phone-arena-flutter-default-rtdb.firebaseio.com', 'phones.json');

      final response = await http.get(url);

      final Map<String, dynamic> firebaseData = json.decode(response.body);
      List<Phone> loadedList = [];

      for (var item in firebaseData.entries) {
        loadedList.add(Phone(
          id: item.key,
          brand: item.value['brand'],
          model: item.value['model'],
          price: item.value['price'],
        ));
      }

      setState(() {
        _phones = loadedList;
      });
    } catch (error) {}
  }

  void _addPhone() async {
    final newItem = await Navigator.of(context).push<Phone>(
      MaterialPageRoute(
        builder: (ctx) => const NewPhone(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() { 
      // isLoading = false;
      _phones.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No Items in the list'),
    );

    if (_phones.isNotEmpty) {
      content = ListView.builder(
          itemCount: _phones.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_phones[index].model),
              subtitle: Text(_phones[index].brand),
              leading: const Icon(Icons.phone_android),
              trailing: Text(
                '€${_phones[index].price}',
              ),
              onTap: () {
                // Navigate to the phone details page
              },
            );
          },
        );
    } // if ends here

    return Scaffold(
        appBar: AppBar(
          title: const Text('Phone Arena'),
          actions: [
            IconButton(
              onPressed: _addPhone,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content,
      );
  }
}

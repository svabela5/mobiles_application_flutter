import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobiles_application_flutter/models/phone.dart';
import 'package:mobiles_application_flutter/widgets/new_phone.dart';
import 'package:http/http.dart' as http;
import 'package:mobiles_application_flutter/widgets/phone_details.dart';

class PhoneList extends StatefulWidget {
  const PhoneList({super.key});

  @override
  State<PhoneList> createState() => _PhoneList();
}

class _PhoneList extends State<PhoneList> {
  List<Phone> _phones = [];
  bool showPhoneDetails = false;
  Phone? selectedPhone;

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

  void setPhoneDetailsToFalse() {
    setState(() {
      showPhoneDetails = false;
    });
  }

  void removePhone(Phone phoneToRemove){
    setState(() {
      final url = Uri.https('phone-arena-flutter-default-rtdb.firebaseio.com', 'phones/${phoneToRemove.id}.json');
      http.delete(url);

      _phones.remove(phoneToRemove);
    });
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
            return Dismissible(
              onDismissed: (direction) {
                removePhone(_phones[index]);
              },
              key: ValueKey(_phones[index].id),
              child: ListTile(
                title: Text(_phones[index].model),
                subtitle: Text(_phones[index].brand),
                leading: const Icon(Icons.phone_android),
                trailing: Text(
                  '€${_phones[index].price}',
                ),
                onTap: () {
                  // Navigate to the phone details page
                  setState(() {
                    showPhoneDetails = true;
                    selectedPhone = _phones[index];
                  });
                },
              ),
            );
          },
        );
    } // if ends here

    if(showPhoneDetails){
      content = PhoneInfo(phone: selectedPhone!, goBackToMainScreen: setPhoneDetailsToFalse);
    }//if ends here

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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobiles_application_flutter/models/phone.dart';

class NewPhone extends StatefulWidget {
  const NewPhone({Key? key}) : super(key: key);

  @override
  State<NewPhone> createState() {
    return _NewPhoneState();
  }
}

class _NewPhoneState extends State<NewPhone> {
  final _formKey = GlobalKey<FormState>();
  var _enteredBrand = '';
  var _enteredModel = '';
  var _enteredPrice = 0.00;

  var isSendingData = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isSendingData = true;
      });

      final url = Uri.https('phone-arena-flutter-default-rtdb.firebaseio.com', 'phones.json');

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'brand': _enteredBrand,
            'model': _enteredModel,
            'price': _enteredPrice,
          }));

      Map<String, dynamic> responseData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(Phone(
          id: responseData['name'],
          brand: _enteredBrand,
          model: _enteredModel,
          price: _enteredPrice,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Brand
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Brand'),
                      ),
                      initialValue: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Must be between 1 and 50 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredBrand = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  //Model
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Model'),
                      ),
                      initialValue: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Must be between 1 and 50 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredModel = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //Price
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Price  (€)'),
                ),
                initialValue: '0.00',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null ||
                      double.tryParse(value)! < 0) {
                    return 'Must be a number greater than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredPrice = double.tryParse(value!)!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: _saveItem,
                      child: isSendingData
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Submit')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

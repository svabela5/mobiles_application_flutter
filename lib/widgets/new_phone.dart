import 'package:flutter/material.dart';

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
  var _enteredModel = 1;
  var _enteredPrice = 0.00;

  var isSendingData = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isSendingData = true;
      });
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
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Brand'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredBrand = value!;
                },
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

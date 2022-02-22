import 'package:flutter/material.dart';
import 'package:form_03/models/item_model.dart';

import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

String? newId;
String? newTitle;
String? newPrice;
String? passedId;
String? initPrice;

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  ItemModel newItem = ItemModel(
    id: '',
    title: '',
    price: 0.0,
  );

  @override
  void didChangeDependencies() {
    final _itemData = Provider.of<Item>(context);
    String _passedId = ModalRoute.of(context)!.settings.arguments as String;

    if (_passedId != '') {
      var itemId = _itemData.findById(_passedId);
      newItem.id = DateTime.now().toString();
      newItem.title = itemId.title;
      newItem.price = itemId.price;
      initPrice = newItem.price.toString();
    } else {
      initPrice = null;
    }
    super.didChangeDependencies();
  }

  void saveForm() {
    final _isValid = _formKey.currentState!.validate();

    if (!_isValid) return;

    _formKey.currentState!.save();
    Provider.of<Item>(context, listen: false).editItem(newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Form app'),
        actions: [
          IconButton(
            onPressed: () {
              saveForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: newItem.title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid title';
                  }
                  return null;
                },
                onSaved: (value) {
                  newItem.title = value!;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: initPrice,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter valid price';
                  }
                  return null;
                },
                onSaved: (value) {
                  newItem.price = double.parse(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

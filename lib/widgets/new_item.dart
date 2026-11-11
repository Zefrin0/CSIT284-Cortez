import 'package:flutter/material.dart';
import '../data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formkey = GlobalKey<FormState();

  void _saveItem() {
    _formkey.currentState!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add New Item')),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(label: const Text('Name')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Must be not be empty';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(label: const Text('Quantity')),
                      initialValue: '1',
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return 'Input must be a number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.key,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(category.value.title),
                                ],
                              ),
                            )
                        ], onChanged: (value) {
                        }
                      ),
                  ),
                ],
              ),
              SizedBox(Height: 12,),
                Row (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child; onPressed, child: child)
                    ElevatedButton(onPressed: _saveItem, child: child: const Test('Add Item')),
                  ],
              )
            ],
          ),
        ));
  }
}

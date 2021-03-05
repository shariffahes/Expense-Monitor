import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Text_Input extends StatefulWidget {
  final Function newValues;

  Text_Input(this.newValues);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<Text_Input> {
  final TextEditingController itemNameController = TextEditingController();

  final TextEditingController itemPriceController = TextEditingController();
  var _dateOfPurchasing = DateTime.now();

  void _submit() {
    final _enteredName = itemNameController.text;
    final _enteredPrice = itemPriceController.text;

    if (_enteredName.isEmpty ||
        _enteredPrice.isEmpty ||
        double.parse(_enteredPrice) < 0) {
      return;
    }

    widget.newValues(
        _enteredName, double.parse(_enteredPrice), _dateOfPurchasing);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1999),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _dateOfPurchasing = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Item Name'),
              // onChanged: (value) {
              //   itemNameInput = value;
              // },
              controller: itemNameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              // onChanged: (value) {
              //   itemPriceInput = value;
              // },
              controller: itemPriceController,
              onSubmitted: (_) {
                _submit();
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        'Transaction Date: ${DateFormat.yMMMd().format(_dateOfPurchasing)}'),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submit,
              child: const Text('Add Transaction'),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

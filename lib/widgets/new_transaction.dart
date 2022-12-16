import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  const NewTransaction({
    super.key,
    required this.addTransaction,
  });

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _inputTitle = TextEditingController();
  final _inputAmount = TextEditingController();
  DateTime? _selectedDate;

  void _handleSubmit() {
    if (_inputTitle.text.isEmpty || _inputAmount.text.isEmpty) {
      return;
    }

    widget.addTransaction(_inputTitle.text, _inputAmount.text);

    Navigator.of(context).pop();
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: _inputTitle,
            onSubmitted: (_) => _handleSubmit(),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: _inputAmount,
            onSubmitted: (_) => _handleSubmit(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          Row(
            children: [
              _selectedDate == null
                  ? const Text('No date selected')
                  : Text(DateFormat('dd/MM/yyyy').format(_selectedDate!)),
              TextButton(
                onPressed: _selectDate,
                child: const Text('Select a date'),
              ),
            ],
          ),
          TextButton(
            onPressed: _handleSubmit,
            style: TextButton.styleFrom(foregroundColor: Colors.purple),
            child: const Text(
              'Add transaction',
            ),
          ),
        ],
      ),
    );
  }
}

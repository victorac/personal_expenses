import 'package:flutter/material.dart';

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
  final inputTitle = TextEditingController();

  final inputAmount = TextEditingController();

  void handleSubmit() {
    if (inputTitle.text.isEmpty || inputAmount.text.isEmpty) {
      return;
    }

    widget.addTransaction(inputTitle.text, inputAmount.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: inputTitle,
            onSubmitted: (_) => handleSubmit(),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: inputAmount,
            onSubmitted: (_) => handleSubmit(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextButton(
            onPressed: handleSubmit,
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

import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';

class NewTransaction extends StatelessWidget {
  final List<Transaction> transactions;
  final Function addTransaction;
  NewTransaction({
    super.key,
    required this.transactions,
    required this.addTransaction,
  });

  final inputTitle = TextEditingController();
  final inputAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: inputTitle,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: inputAmount,
          ),
          TextButton(
            onPressed: () {
              addTransaction(inputTitle.text, inputAmount.text);
            },
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

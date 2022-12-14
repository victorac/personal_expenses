import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';

import '../models/transaction.dart';

class TransactionController extends StatefulWidget {
  const TransactionController({super.key});

  @override
  State<TransactionController> createState() => _TransactionControllerState();
}

class _TransactionControllerState extends State<TransactionController> {
  final List<Transaction> transactions = [
    Transaction(
      id: '0',
      title: 'Shoes',
      amount: 17.32,
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      title: 'Books',
      amount: 127.32,
      date: DateTime.now(),
    ),
  ];

  void addTransaction(String title, String amount) {
    setState(() {
      transactions.add(Transaction(
        id: "id",
        title: title,
        amount: double.parse(amount),
        date: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          transactions: transactions,
          addTransaction: addTransaction,
        ),
        TransactionList(
          transactions: transactions,
        ),
      ],
    );
  }
}

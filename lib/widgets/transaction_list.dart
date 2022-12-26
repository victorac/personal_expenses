import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? SizedBox(
            height: 200,
            child: Column(
              children: [
                const Text('No Transactions found'),
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/empty_3.png'),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: ((context, index) => TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction,
                )),
            itemCount: transactions.length,
          );
  }
}

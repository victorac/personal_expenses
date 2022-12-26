import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    final amountFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                amountFormat.format(transaction.amount),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('MMMM d, y', 'pt_BR').format(transaction.date),
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.headline6?.fontFamily,
            color: Colors.blueGrey,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}

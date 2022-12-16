import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({super.key, required this.transactions});
  final amountFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    return SizedBox(
      height: 300,
      child: transactions.isEmpty
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
              itemBuilder: ((context, index) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              amountFormat.format(transactions[index].amount),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat('MMMM d, y', 'pt_BR')
                            .format(transactions[index].date),
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.headline6?.fontFamily,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  )),
              itemCount: transactions.length,
            ),
    );
  }
}

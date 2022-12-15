import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({super.key, required this.transactions});

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
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              DateFormat('MMMM d, y', 'pt_BR')
                                  .format(transactions[index].date),
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.fontFamily,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              itemCount: transactions.length,
            ),
    );
  }
}

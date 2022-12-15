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
      height: 400,
      child: ListView.builder(
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
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index].title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('MMMM d, y', 'pt_BR')
                            .format(transactions[index].date),
                        style: const TextStyle(
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

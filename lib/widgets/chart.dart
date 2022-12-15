import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalAmount);

      return {
        'weekDay': DateFormat.E().format(weekDay),
        'totalAmount': totalAmount,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Row(
        children: groupedTransactionValues
            .map(
              (e) => Column(
                children: [
                  Container(
                    color: Colors.amber,
                    height: 10,
                  ),
                  Text(e['weekDay'].toString())
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

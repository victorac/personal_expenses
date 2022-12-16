import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
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

      return {
        'weekDay': DateFormat.E().format(weekDay).substring(0, 1),
        'totalAmount': totalAmount,
      };
    }).reversed.toList();
  }

  double get weekTotal {
    var total = 0.0;
    for (var i = 0; i < recentTransactions.length; i++) {
      total += recentTransactions[i].amount;
    }
    if (total == 0) {
      return 1;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTransactionValues.map(
          (e) {
            var weekPercentage = (e['totalAmount'] as double) / weekTotal;
            return Expanded(
              child: ChartBar(
                weekPercentage: weekPercentage,
                amount: e['totalAmount'] as double,
                weekDay: e['weekDay'].toString(),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

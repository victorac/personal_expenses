import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final double weekPercentage;
  final String weekDay;
  final double amount;
  const ChartBar({
    super.key,
    required this.weekPercentage,
    required this.amount,
    required this.weekDay,
  });

  @override
  Widget build(BuildContext context) {
    var amountFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          FittedBox(child: Text(amountFormat.format(amount))),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white12,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: weekPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(weekDay)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final double weekPercentage;
  final String weekDay;
  final double amount;
  ChartBar({
    super.key,
    required this.weekPercentage,
    required this.amount,
    required this.weekDay,
  });
  final amountFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * .15,
            child: FittedBox(child: Text(amountFormat.format(amount))),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          SizedBox(
            height: constraints.maxHeight * .6,
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
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          SizedBox(
            height: constraints.maxHeight * .15,
            child: FittedBox(child: Text(weekDay)),
          )
        ],
      );
    });
  }
}

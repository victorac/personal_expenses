import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 50 * (1 - weekPercentage),
            width: 10,
          ),
          Container(
            color: Colors.amber,
            height: 50 * weekPercentage,
            width: 10,
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

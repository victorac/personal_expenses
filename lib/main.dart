import 'package:flutter/material.dart';
import './widgets/transactions_controller.dart';

void main() => runApp(const PersonalExpenses());

class PersonalExpenses extends StatelessWidget {
  const PersonalExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
        ),
        body: Column(
          children: const [
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Text('Chart!'),
              ),
            ),
            TransactionController(),
          ],
        ),
      ),
    );
  }
}

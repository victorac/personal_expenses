import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const PersonalExpenses(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'Hammersmith One',
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PersonalExpenses extends StatefulWidget {
  const PersonalExpenses({super.key});

  @override
  State<PersonalExpenses> createState() => _PersonalExpensesState();
}

class _PersonalExpensesState extends State<PersonalExpenses> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: '0',
    //   title: 'Shoes',
    //   amount: 17.32,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '1',
    //   title: 'Books',
    //   amount: 127.32,
    //   date: DateTime.now(),
    // ),
    Transaction(
      id: 'id',
      title: 'Fish',
      amount: 100,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  void _addTransaction(String title, String amount) {
    setState(() {
      _transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: DateTime.now(),
      ));
    });
  }

  void _startAddNewTransaction(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) =>
          NewTransaction(addTransaction: _addTransaction),
    );
  }

  List<Transaction> get _recentTransactions {
    List<Transaction> recentTransactions = _transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
    return recentTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Chart(recentTransactions: _recentTransactions),
            ),
            TransactionList(
              transactions: _transactions,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

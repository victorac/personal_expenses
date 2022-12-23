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
    // Transaction(
    //   id: 'id',
    //   title: 'Fish',
    //   amount: 100,
    //   date: DateTime.now().subtract(const Duration(days: 2)),
    // ),
  ];

  void _addTransaction(String title, String amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: date,
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

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
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

  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final transactionList = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .7,
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
    final portraitChartHeight = (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
        0.3;
    final landscapeChartHeight = portraitChartHeight / 0.3 * 0.7;
    final portraitChart = Chart(
      recentTransactions: _recentTransactions,
      height: portraitChartHeight,
    );
    final landscapeChart = Chart(
      recentTransactions: _recentTransactions,
      height: landscapeChartHeight,
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final switchButton = Switch(
        value: _showChart,
        onChanged: (value) => setState(() {
              _showChart = value;
            }));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) switchButton,
            if (isLandscape && _showChart) landscapeChart,
            if (!isLandscape) portraitChart,
            if (!isLandscape || !_showChart) transactionList,
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

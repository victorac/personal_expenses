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
  final List<Transaction> _transactions = [];

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

  AppBar _buildAppBar() {
    return AppBar(
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
  }

  List<Widget> _buildPortraitBody(double height, Widget transactionList) {
    final portraitChartHeight = height * 0.3;
    final chart = Chart(
      recentTransactions: _recentTransactions,
      height: portraitChartHeight,
    );
    return [chart, transactionList];
  }

  List<Widget> _buildLandscapeBody(double height, Widget transactionList) {
    final landscapeChartHeight = height * 0.7;
    final switchButton = Switch(
        value: _showChart,
        onChanged: (value) => setState(() {
              _showChart = value;
            }));
    List<Widget> body = [switchButton];
    if (_showChart) {
      final chart = Chart(
        recentTransactions: _recentTransactions,
        height: landscapeChartHeight,
      );
      body.add(chart);
    } else {
      body.add(transactionList);
    }
    return body;
  }

  @override
  Widget build(BuildContext context) {
    final appBar = _buildAppBar();
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
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingTop = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;
    final finalHeight = screenHeight - appBarHeight - paddingTop;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final body = isLandscape
        ? _buildLandscapeBody(finalHeight, transactionList)
        : _buildPortraitBody(finalHeight, transactionList);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [...body],
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

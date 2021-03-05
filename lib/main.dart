import './widgets/TextInput.dart';
import 'package:flutter/material.dart';
import './model/Transaction.dart';
import './widgets/transacion_list.dart';
import './widgets/Chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Monitor',
        home: Home(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'QpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 19,
                        fontWeight: FontWeight.bold))),
            errorColor: Colors.red));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _transactions = [];

  bool _showChart = false;

  void _addNewTransaction(String name, double price, DateTime purchasedDate) {
    setState(() {
      _transactions.add(
          Transaction(id: 't1', name: name, price: price, date: purchasedDate));
    });
  }

  List<Transaction> get _recentTransaction {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddingTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(ctx).viewInsets.bottom),
                  child: Text_Input(_addNewTransaction)));
        });
  }

  void _deleteItem(int i) {
    setState(() {
      _transactions.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBarWidget = AppBar(
      title: Text(
        'Expense Monitor',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddingTransaction(context);
            })
      ],
    );

    final transList = Container(
        height: (mediaQuery.size.height -
                appBarWidget.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactions, _deleteItem));

    final bodyWidget = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Display Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    })
              ],
            ),
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBarWidget.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransaction))
                : transList,
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        appBarWidget.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransaction)),
          if (!isLandscape) transList,
        ],
      ),
    ));

    return Scaffold(
      appBar: appBarWidget,
      body: bodyWidget,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddingTransaction(context);
        },
      ),
    );
  }
}

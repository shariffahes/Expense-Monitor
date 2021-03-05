import 'package:flutter/material.dart';
import '../model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteItem;

  const TransactionList(this._transactions, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No added transactions yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.09,
                ),
                Container(
                    //margin: EdgeInsets.only(top: 20),
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 7),
                      child: FittedBox(
                        child: Text(
                            '\$${_transactions[index].price.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactions[index].name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(_transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          onPressed: () {
                            _deleteItem(index);
                          },
                          icon: const Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor,
                          label: const Text('Delete'))
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteItem(index);
                          },
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
              // return Item(_transactions[index].name,
              //     _transactions[index].price, _transactions[index].date);
            },
            itemCount: _transactions.length,
          );

    // children: _transactions
    //     .map(
    //       (e) => Card(child: Item(e.name, e.price, e.date)),
    //     )
    //     .toList()),

    ;
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item extends StatelessWidget {
  final double price;
  final String name;
  final DateTime date;

  const Item(this.name, this.price, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        child: Row(
          children: [
            Container(
              child: Text(
                '\$${price.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              margin: const EdgeInsets.only(left: 5, right: 10),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )),
            ),
            Column(
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  DateFormat.yMMMMd().format(date),
                  style: TextStyle(color: Colors.grey),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}

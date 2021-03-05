import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final double price;
  final String name;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.date});
}

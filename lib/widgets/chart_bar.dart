import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentOfTotalSpending;

  const ChartBar(this.label, this.spendingAmount, this.percentOfTotalSpending);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(children: [
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.08,
        ),
        Container(
          height: constraints.maxHeight * 0.5,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: percentOfTotalSpending,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.08,
        ),
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)))
      ]);
    });
  }
}

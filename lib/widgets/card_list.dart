import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vector_cg/widgets/activity_cards.dart';

class ShopList extends StatefulWidget {
  final int stat; // receives the value

  ShopList({required this.stat});

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  var formatter = NumberFormat('#,###,###');

  @override
  Widget build(BuildContext context) {
    final activity = Provider.of<List>(context);

    return Column(children: [
      Expanded(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
              elevation: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      formatter.format(widget.stat).toString(),
                      style: TextStyle(fontSize: 60, color: Color(0xFF72BF44)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      "Shops",
                      style: TextStyle(color: Color(0xFF72BF44), fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            ActivityList(),
          ],
        ),
      ),
      SizedBox(
        height: 48,
        width: double.infinity,
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/new_activity',
                  arguments: activity);
            },
            child: Text("CREATE NEW ACTIVITY"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Color(0xFF72BF44)))),
      ),
    ]);
  }
}

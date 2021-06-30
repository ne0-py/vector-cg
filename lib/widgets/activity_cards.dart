import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ActivityList extends StatefulWidget {
  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    //get all the documents from the acitivity collection
    final activity = Provider.of<List>(context);
    //check who is currently logged in
    final user = Provider.of<User?>(context);
    List activityData = [];

    void getData(List data) {
      for (var act in activity) {
        //if the user is the owner of the document only then we will list it
        if (user!.uid.substring(0, 28) == act['docId'].substring(0, 28)) {
          data.add(act.data());
        }
      }
    }

    getData(activityData);

    return Expanded(
      child: Container(
        color: Color(0xFFEEEEEE),
        child: ListView.builder(
          itemCount: activityData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.all(25),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                              activityData[index]['state'].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFC0C0C0))),
                        ),
                        Text(activityData[index]['city'],
                            style: TextStyle(fontSize: 24))
                      ],
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('dd-MM-yyyy')
                        .format(activityData[index]['date'].toDate())
                        .toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

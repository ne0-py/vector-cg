import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});

  //collections reference
  final CollectionReference activityCollection =
      FirebaseFirestore.instance.collection('activity');

  Future newUserActivity(String docId, DateTime date, String state, String city,
      String zipCode) async {
    return await activityCollection.doc(uid).set({
      'docId': docId,
      'date': date,
      'state': state,
      'city': city,
      'zipCode': zipCode
    });
  }

  //get stream of collection
  Stream<List> get activity {
    return activityCollection.snapshots().map((snapShot) => snapShot.docs);
  }

  Stream<DocumentSnapshot> get userData {
    return activityCollection.doc(uid).snapshots();
  }
}

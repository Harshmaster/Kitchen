import '../widgets/OrderCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {


@override
void initState() { 
  super.initState();

}

  String todayDate = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();

  Future<void> fetchData() async {
    await Firestore.instance
        .collection("all orders")
        .document(todayDate)
        .collection("orders")
        .where("status", isEqualTo: 'Ongoing')
        .getDocuments()
        .then((docs) {});
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection("all orders")
            .document(todayDate)
            .collection("orders")
            .where("status", isEqualTo: 'Ongoing')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  customerName: snapshot.data.documents[index].data["name"],
                  mobile: snapshot.data.documents[index].data["phone"],
                  status: snapshot.data.documents[index].data["status"],
                  payment: snapshot.data.documents[index].data["payment"],
                  plates: snapshot.data.documents[index].data["plates"],
                  id: snapshot.data.documents[index].data["id"],

                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

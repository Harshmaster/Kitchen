import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  TextEditingController phoneController;
  TextEditingController nameController;
  ContactList({
    this.phoneController,
    this.nameController,
  });

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Icon(Icons.person),
          title: Text('CHOOSE CONTACT'),
          backgroundColor: Colors.orange[900],
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('customers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      widget.phoneController.text =
                          snapshot.data.documents[index].data["phone"];
                      widget.nameController.text =
                          snapshot.data.documents[index].data["name"];
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(snapshot.data.documents[index].data["name"]),
                      subtitle:
                          Text(snapshot.data.documents[index].data["phone"]),
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ));
  }
}

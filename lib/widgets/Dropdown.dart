import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dropdown extends StatefulWidget {
  final List<String> itemList;
  final String hint;
  final double leftMargin;
  TextEditingController value;
  final String id;
  final bool isPayment;
  final bool isStatus;

  Dropdown({
    this.itemList,
    this.hint,
    this.leftMargin,
    this.value,
    this.id,
    this.isPayment = false,
    this.isStatus = false,
  });

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String selectedItem;

  String todayDate = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: 0,
        top: 20,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        underline: Container(
          color: Colors.black,
          width: 3,
        ),
        style: TextStyle(
            color: Color.fromRGBO(82, 90, 101, 1),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        hint: Text(widget.hint),
        value: selectedItem,
        onChanged: (String value) async {

          if (widget.isStatus) {
            await Firestore.instance
                .collection("all orders")
                .document(todayDate)
                .collection("orders")
                .document(widget.id)
                .updateData({
              "status": value,
            });
          }

          if (widget.isPayment) {
            await Firestore.instance
                .collection("all orders")
                .document(todayDate)
                .collection("orders")
                .document(widget.id)
                .updateData({
              "payment": value,
            });
          }
        },
        items: widget.itemList.map(
          (String variable) {
            return DropdownMenuItem<String>(
                value: variable, child: Text(variable));
          },
        ).toList(),
      ),
    );
  }
}

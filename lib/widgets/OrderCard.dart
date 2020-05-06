import '../widgets/Dropdown.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  String payment;
  String customerName;
  String mobile;
  String status;
  String id;
  String plates;

  OrderCard(
      {this.payment,
      this.customerName,
      this.mobile,
      this.status,
      this.id,
      this.plates});
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  TextEditingController paymentController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'NAME',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.customerName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Mobile',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.mobile,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Order Id',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.id,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Plates',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.plates,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Dropdown(
              isUpdate: true,
               isOrderId:true,
              isPayment: true,
              id: widget.id,
              leftMargin: 0,
              value: paymentController,
              hint: widget.payment,
              itemList: [
                "Pending",
                "Cash",
                "Self Paid",
                "Paytm-1",
                "Paytm-2",
                "G-Pay",
              ],
            ),
            Dropdown(
             isUpdate: true,
              isStatus: true,
              id: widget.id,
              value: statusController,
              leftMargin: 0,
              hint: widget.status,
              itemList: ["Completed", "Ongoing"],
            )
          ],
        ),
      ),
    );
  }
}

import '../widgets/PaymentTabBar.dart';
import 'package:flutter_otp/flutter_otp.dart';
import '../widgets/Dropdown.dart';
import '../widgets/OrdersTabBar.dart';
import '../widgets/generalField.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int total = 0;
  int delivered = 0;
  String orderId;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController platesController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  String todayDate = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();

  String status;

  @override
  void initState() {
    super.initState();
    fetchData();
    paymentController.text = 'Pending';
    status = 'Ongoing';
  }

  fetchData() async {
    await Firestore.instance
        .collection("all orders")
        .document(todayDate)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        setState(() {
          total = doc["total"];
          delivered = doc["delivered"];
        });
      }
    }).then((value) {
      print(total);
      print(delivered);
    });
  }

  genereateId() async {
    orderId = 'AA00' + (total + 1).toString();
  }

  writeData() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitCircle(color: Colors.white);
        });

    await genereateId().then((unused) async {
      await Firestore.instance
          .collection("all orders")
          .document(todayDate)
          .collection("orders")
          .document(orderId)
          .setData({
        "name": nameController.text,
        "phone": phoneController.text,
        "plates": platesController.text,
        "payment": paymentController.text,
        "status": status,
        "id": orderId,
      }).then((value) async {
        await Firestore.instance
            .collection("all orders")
            .document(todayDate)
            .setData({
          "total": total + 1,
        });
      }).then((useless) async {
        print(phoneController.text.toString());
        FlutterOtp().sendOtp(phoneController.text.toString(),
            'Hi ${nameController.text} ! Your Order Has been placed Successfully. Order Id: $orderId');
        fetchData();
        setState(() {
          todayDate = DateTime.now().day.toString() +
              "-" +
              DateTime.now().month.toString() +
              "-" +
              DateTime.now().year.toString();

          nameController.clear();
          phoneController.clear();
          platesController.clear();
          paymentController.text = 'Pending';
        });

        Navigator.of(context).pop();

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "SUCCESS",
                  style: TextStyle(color: Colors.green[900]),
                ),
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Placed Successfully.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Order ID : $orderId',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  InkWell(
                    onTap: () {
                      _launchURL();
                    },
                    child: Container(
                      width: 23,
                      height: 23,
                      child: Image.asset('assets/whatsapp.png'),
                    ),
                  ),
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      });
    });
  }

  int _currentIndex = 0;

  onTabChanged(value) {
    print(value);
    setState(() {
      _currentIndex = value;
    });
  }

  List<Widget> widgetList = [
    HomePage(),
    OrdersTabBar(),
    PaymentTabBar(),
  ];

  _launchURL() async {
    var url =
        'https://api.whatsapp.com/send?phone=+91${phoneController.text}&text=Hi ${nameController.text} ! Your Order Has been placed Successfully. Order Id: $orderId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.orange[900],
          elevation: 10,
          iconSize: 21,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          onTap: onTabChanged,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
              ),
              title: Text(
                "New Order",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                ),
                title: Column(
                  children: <Widget>[
                    Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.contact_phone,
              ),
              title: Text(
                "Payment",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
          ],
          selectedItemColor: Colors.amberAccent,
        ),
        appBar: AppBar(
          elevation: 0,
          leading: Icon(Icons.fastfood),
          title: Text('CHHOLE BHATOORE'),
          backgroundColor: Colors.orange[900],
        ),
        body: _currentIndex == 0
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.82,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GeneralField(
                        controller: nameController,
                        label: 'Customer Name',
                        hint: 'eg. Harsh Singh',
                      ),
                      GeneralField(
                        controller: phoneController,
                        label: 'Phone Number',
                        hint: 'eg. 981511555',
                        type: TextInputType.number,
                      ),
                      GeneralField(
                        controller: platesController,
                        label: 'No. of Plates',
                        hint: 'eg. 5 plates',
                        type: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Text(
                          'Mode of Payment',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Dropdown(
                        value: paymentController,
                        leftMargin: 30,
                        hint: "Pending",
                        itemList: [
                          "Pending",
                          "Cash",
                          "Self Paid",
                          "Paytm-1",
                          "Paytm-2",
                          "G-Pay",
                        ],
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            right: 22, left: 22, top: 20, bottom: 20),
                        elevation: 3,
                        child: Container(
                          child: InkWell(
                            child: Container(
                                child: Center(
                                  child: Text(
                                    'Place Order',
                                    style: TextStyle(
                                      fontFamily: ' ',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.orange[900],
                                        Colors.orange[900],
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ))),
                            onTap: () {
                              writeData();
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:20,right:20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total Orders',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              total.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : widgetList[_currentIndex]);
  }
}

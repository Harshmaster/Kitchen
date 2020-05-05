import '../screens/Payment.dart';
import 'package:flutter/material.dart';

class PaymentTabBar extends StatefulWidget {
  @override
  _PaymentTabBarState createState() => _PaymentTabBarState();
}

class _PaymentTabBarState extends State<PaymentTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 10,
                top: 10,
              ),
              child: Icon(
                Icons.person,
                color: Color(0xfff4d35e),
                size: 30,
              ),
            )
          ],
          elevation: 7,
          backgroundColor: Colors.orange[900],
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
              color: Color(0xfff4d35e),
              width: 5,
            )),
            indicatorWeight: 7,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'Pending',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Cash',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Self Paid',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Paytm-1',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Paytm-2',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'G-pay',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: TabBarView(
          children: [
            Payment(payment: 'Pending',),
            Payment(payment:'Cash'),
            Payment(payment:'Self Paid'),
            Payment(payment:'Paytm-1'),
            Payment(payment:'Paytm-2'),
            Payment(payment:'G-Pay'),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

import '../screens/CompletedOrders.dart';
import '../screens/OngoingOrders.dart';
import 'package:flutter/material.dart';

class OrdersTabBar extends StatefulWidget {
  @override
  _OrdersTabBarState createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends State<OrdersTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                  'Ongoing',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Completed ',
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
            Ongoing(),
            Completed(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

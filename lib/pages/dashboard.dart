import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_cg/services/auth.dart';
import 'package:vector_cg/widgets/card_list.dart';
import 'package:vector_cg/services/database.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();
  final DataBaseService dataBaseService = DataBaseService(uid: '');

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List>(
      create: (BuildContext context) => dataBaseService.activity,
      initialData: [],
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: ListView(children: [
            DrawerHeader(
              child: Text(
                "A Drawer",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(color: Color(0xFF262626)),
            ),
          ]),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xFF262626),
            title: Text("Dashboard"),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh_sharp)),
              IconButton(
                  onPressed: () async {
                    _auth.signOut();
                  },
                  icon: Icon(Icons.logout_sharp)),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("This Week", style: TextStyle(fontSize: 12)),
                ),
                Tab(
                  child: Text("This Week", style: TextStyle(fontSize: 12)),
                ),
                Tab(
                  child: Text("This Month", style: TextStyle(fontSize: 12)),
                ),
                Tab(
                  child: Text("Since Start", style: TextStyle(fontSize: 12)),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            ShopList(stat: 41),
            ShopList(stat: 307),
            ShopList(stat: 1186),
            ShopList(stat: 67153),
          ]),
        ),
      ),
    );
  }
}

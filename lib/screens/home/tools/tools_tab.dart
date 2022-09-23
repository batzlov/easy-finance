import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// shared
import 'package:easy_finance/shared/constants.dart';
import 'package:easy_finance/shared/locals.dart';
import 'package:easy_finance/shared/loading.dart';

import 'package:easy_finance/screens/home/tools/compound_interest.dart';
import 'package:easy_finance/screens/home/tools/goal_saving.dart';

import 'package:easy_finance/services/auth.dart';

class ToolsTab extends StatefulWidget {
  @override
  _ToolsTabState createState() => _ToolsTabState();
}

class _ToolsTabState extends State<ToolsTab> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();  

  TabController _tabController;

  List<Widget> tabs = [
    Tab(
      text: 'Zinseszins'
    ),
    Tab(
      text: 'Zielsparen'
    ),
  ];

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyBackground,
      appBar: AppBar(
        title: Text('Werkzeuge'),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
            }
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: TabBar(
          controller: _tabController,
          isScrollable: true,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          indicatorColor: Colors.white,
          tabs: tabs
        ),
      )
    ),
    body: TabBarView(
      controller: _tabController,
      children: <Widget>[
        CompoundInterest(),
        GoalSaving(),
      ]
      ) 
    );
  }
}
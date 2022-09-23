import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/services/database.dart';
import 'package:easy_finance/services/auth.dart';

import 'package:easy_finance/models/expense.dart';
import 'package:easy_finance/models/user.dart';

import 'package:easy_finance/screens/home/shared/types.dart';
import 'package:easy_finance/screens/home/earnings/earnings_type_screen.dart';

class EarningsTab extends StatefulWidget {
  @override
  _EarningsTabState createState() => _EarningsTabState();
}

class _EarningsTabState extends State<EarningsTab> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  int index = 0;

  TabController _tabController;

  List<Widget> tabs = <Widget>[
    Tab(
      text: 'Gesamt',
    ),
    Tab(
      text: 'Monatlich'
    ),
    Tab(
      text: 'Vierteljährlich'
    ),
    Tab(
      text: 'Halbjährlich'
    ),
    Tab(
      text: 'Jährlich'
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Einnahmen'),
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
                tabs: tabs,
            ),
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          EarningsTypeScreen(
            earningsType: EarningType.all
          ),
          EarningsTypeScreen(
            earningsType: EarningType.monthly
          ),
          EarningsTypeScreen(
            earningsType: EarningType.quarterly
          ),
          EarningsTypeScreen(
            earningsType: EarningType.biannual
          ),
          EarningsTypeScreen(
            earningsType: EarningType.yearly
          ),
        ]
      )
    );
  }
}
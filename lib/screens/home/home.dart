import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// services
import 'package:easy_finance/services/auth.dart';
import 'package:easy_finance/services/database.dart';

import 'package:easy_finance/models/expense.dart';
import 'package:easy_finance/models/earning.dart';
import 'package:easy_finance/models/investment.dart';
import 'package:easy_finance/models/user.dart';

import 'package:easy_finance/shared/constants.dart';

// screens
import 'package:easy_finance/screens/home/overview/overview_tab.dart';
import 'package:easy_finance/screens/home/tools/tools_tab.dart';
import 'package:easy_finance/screens/home/expenses/expenses_tab.dart';
import 'package:easy_finance/screens/home/earnings/earnings_tab.dart';
import 'package:easy_finance/screens/home/investments/investments_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final AuthService _authService = AuthService();

  static List<Widget> _tabs = <Widget>[
    OverviewTab(),
    ExpensesTab(),
    EarningsTab(),
    InvestmentsTab(),
    ToolsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Expense>>.value(value: DatabaseService(uid: user.uid).expenses),
        StreamProvider<List<Earning>>.value(value: DatabaseService(uid: user.uid).earnings),
        StreamProvider<List<Investment>>.value(value: DatabaseService(uid: user.uid).investments)
      ],
      child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _tabs.elementAt(_currentIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Übersicht'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Ausgaben'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.euro_symbol),
            label: 'Einnahmen'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Investments'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plumbing),
            label: 'Tools'
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: grey,
        // selectedItemColor: Color(0xff5A5474),
        onTap: _onItemTapped
      ),
    ),
    );
  }
}
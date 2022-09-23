import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/services/database.dart';
import 'package:easy_finance/services/auth.dart';

import 'package:easy_finance/models/expense.dart';
import 'package:easy_finance/models/user.dart';

import 'package:easy_finance/screens/home/shared/types.dart';

import 'package:easy_finance/screens/home/expenses/expense_type_screen.dart';
import 'package:easy_finance/screens/home/expenses/add_expense_form.dart';



class ExpensesTab extends StatefulWidget {
  @override
  _ExpensesTabState createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  
  TabController _tabController;

  List<Widget> _tabs = <Widget>[
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
    _tabController = new TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<Expense>>.value(
      value: DatabaseService(uid: user.uid).expenses,
      child: Scaffold(
        backgroundColor: lightGreyBackground,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ausgaben'),
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
                  tabs: _tabs,
              ),
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ExpenseTypeScreen(
              expenseType: ExpenseType.all
            ),
            ExpenseTypeScreen(
              expenseType: ExpenseType.monthly
            ),
            ExpenseTypeScreen(
              expenseType: ExpenseType.quarterly
            ),
            ExpenseTypeScreen(
              expenseType: ExpenseType.biannual
            ),
            ExpenseTypeScreen(
              expenseType: ExpenseType.yearly
            ),
          ]
        )
      ),
    );
  }
}
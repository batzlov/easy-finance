import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/services/auth.dart';
import 'package:easy_finance/services/database.dart';

import 'package:easy_finance/models/user.dart';
import 'package:easy_finance/models/expense.dart';
import 'package:easy_finance/models/earning.dart';

import 'package:easy_finance/screens/home/overview/documentation.dart';
import 'package:easy_finance/screens/home/overview/expense_philosophie.dart';
import 'package:easy_finance/screens/home/overview/invest_philosophie.dart';

class OverviewTab extends StatefulWidget {
  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> { 
  final AuthService _authService = AuthService();

  bool _showExpensesPreview = true;
  static const Color red = Color(0xffe57373);
  static const Color green = Color(0xff81C784);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final expensesTotal = Provider.of<List<Expense>>(context) ?? [];
    final earningsTotal = Provider.of<List<Earning>>(context) ?? [];

    String _summedUpExpenses = DatabaseService(uid: user.uid).getMothlyExpenseTotal(expensesTotal);
    String _summedUpEarnings = DatabaseService(uid: user.uid).getMothlyEarningTotal(earningsTotal);

    String _expenseText = 'Monatliche Ausgaben';
    String _earningsText = 'Monatliche Einnahmen';

    void _switchPreviewContent()
    {
      setState(() {
        _showExpensesPreview = !_showExpensesPreview;
      });
    }

    return Scaffold(
      backgroundColor: lightGreyBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
        title: Text('Übersicht'),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
            }
          ),
        ]
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: new InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpensePhilosophie()
                    )
                  );
                },
                child: Image.asset(
                  'assets/images/start1.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(10.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      _showExpensesPreview ? red : green,
                      _showExpensesPreview ? red : green,
                    ],
                  )
                ),
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _switchPreviewContent();
                          },
                        ),
                        Text(
                          _showExpensesPreview ? _summedUpExpenses : _summedUpEarnings,
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 20.0
                          )
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _switchPreviewContent();
                          },
                        )
                      ]
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          _showExpensesPreview ? _expenseText : _earningsText,
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.0
                          )
                        )
                      ),
                    )
                  ]
                )
              )
            ),
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: new InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvestPhilosophie()
                    )
                  );
                },
                child: Image.asset(
                  'assets/images/start4.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(10.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      lightBlue,
                      lightBlue,
                    ],
                  )
                ),
                padding: EdgeInsets.all(5.0),
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Documentation()
                      )
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 7.0
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Wert der Dokumentation",
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 20.0
                            )
                          ),
                        ]
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "unbezahlbar",
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 24.0
                            )
                          )
                        ),
                      )
                    ]
                  ),
                )
              )
            ),
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:easy_finance/models/expense.dart';
import 'package:easy_finance/models/user.dart';
import 'package:provider/provider.dart';
import 'package:easy_finance/services/database.dart';
import 'package:easy_finance/screens/home/expenses/add_expense_form.dart';
import 'package:easy_finance/shared/constants.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  ExpenseTile({
    this.expense
  });

  @override
  Widget build(BuildContext context) 
  {
    final user = Provider.of<User>(context);

    void _showUpdateExpenseBottomSheet()
    {
      showModalBottomSheet(
        backgroundColor: lightGreyBackground,
        context: context, 
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, 
                top: 20.0,
                left: 10.0,
                right: 10.0
              ),
              child: AddExpenseForm(expense)
            ),
          );
        }
      );
    }

    return Container(
      child: Card(
        elevation: tileElevation,
        margin: EdgeInsets.fromLTRB(
          20.0,
          5.0,
          20.0,
          5.0
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          dense: false,
          leading: CircleAvatar(
            radius: 25.0,
            //backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
            backgroundImage: AssetImage(
              'assets/images/eevee.png'
            ),
            backgroundColor: lightRed
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DatabaseService(uid: user.uid).removeExpense(expense.uid);
            }
          ),
          onLongPress: () {
            _showUpdateExpenseBottomSheet();
          },
          title: Text(NumberFormat.currency(locale: 'EURO').format(expense.value)),
          subtitle: Text(expense.name)
        )
      )
    );
  }
}
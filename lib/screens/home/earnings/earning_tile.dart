import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:easy_finance/services/database.dart';

import 'package:easy_finance/models/earning.dart';
import 'package:easy_finance/models/user.dart';

import 'package:easy_finance/shared/constants.dart';

import 'package:easy_finance/screens/home/earnings/add_earning_form.dart';

class EarningTile extends StatelessWidget {
  final Earning earning;

  EarningTile({
    this.earning
  });
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void _showUpdateEarningBottomSheet()
    {
      showModalBottomSheet(
        context: context, 
        backgroundColor: lightGreyBackground,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, 
                top: 20.0,
                left: 10.0,
                right: 10.0
              ),
              child: AddEarningForm(earning)
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
            backgroundImage: AssetImage(
              'assets/images/eevee.png'
            ),
            backgroundColor: lightGreen
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DatabaseService(uid: user.uid).removeEarning(earning.uid);
            }
          ),
          onLongPress: () {
            _showUpdateEarningBottomSheet();
          },
          title: Text(NumberFormat.currency(locale: 'EURO').format(earning.value)),
          subtitle: Text(earning.name)
        )
      )
    );
  }
}

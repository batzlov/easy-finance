import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// shared
import 'package:easy_finance/shared/constants.dart';

class GoalSaving extends StatefulWidget {
  @override
  _GoalSavingState createState() => _GoalSavingState();
}

class _GoalSavingState extends State<GoalSaving> {
  final _formKey = GlobalKey<FormState>();

  double _startCapital = 0;
  double _endCapital = 0;
  double _yearsToSave = 0;
  double _interestRate = 0;

  double _finalRate = 0;

  var money = new NumberFormat.currency(locale: 'EURO', symbol: '€');

  double _calcMonthlySavigsRate()
  {
    double step = 10;

    double total = 0;
    double capital = 0;

    double totalInterest = 0;
    double totalCapital = 0;

    double monthlyRate = 1;
    while(total <= _endCapital)
    {
      capital = _startCapital;

      totalInterest = 0;
      totalCapital = _startCapital;

      for(int i = 0; i < _yearsToSave; i++)
      {
        capital  += 6.0 * monthlyRate;

        double _tempInterest = (capital * _interestRate) / 100;

        totalInterest += _tempInterest;
        capital += _tempInterest + 6.0 * monthlyRate;
        totalCapital = (monthlyRate * 12 * _yearsToSave) + _startCapital;

        setState(() {
          total = totalInterest + totalCapital;
        });
      }

      if(total <= _endCapital)
      {
        double tempCapital = capital + 6 * (monthlyRate + step);
        double tempInt = (tempCapital * _interestRate) / 100;
        tempCapital += tempInt + 6 * (monthlyRate + step);
        double tot = tempCapital + tempInt;

        if(tot <= _endCapital)
        {
          monthlyRate += step;
        }
        else
        {
          monthlyRate++;
        }
      }
      else
      {
        setState(() {
          _finalRate = monthlyRate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              elevation: cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0
                  ),
                  Text(
                    'Zielsparen',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0
                      ),
                      child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Spardauer in Jahren',
                            labelText: 'Spardauer'
                          ),
                          validator: (value) {
                            if(value.isEmpty || double.tryParse(value) == null)
                            {
                              return 'Bitte füge eine Spardauer hinzu';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _yearsToSave = double.parse(value);
                            });
                          }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Einmalanlage/Startkapital',
                            labelText: 'Startkapital'
                          ),
                          validator: (value) {
                            if(value.isEmpty || double.tryParse(value) == null)
                            {
                              return 'Bitte füge eine Startkapital hinzu';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _startCapital = double.parse(value);
                            });
                          }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Gewünschtes Endkapital',
                            labelText: 'Endkapital'
                          ),
                          validator: (value) {
                            if(value.isEmpty || double.tryParse(value) == null)
                            {
                              return 'Bitte füge eine Endkapital hinzu';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _endCapital = double.parse(value);
                            });
                          }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Zinssatz pro Jahr in %',
                            labelText: 'Zinssatz'
                          ),
                          validator: (value) {
                            if(value.isEmpty || double.tryParse(value) == null)
                            {
                              return 'Bitte füge eine Rendite hinzu';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _interestRate = double.parse(value);
                            });
                          }
                        ),
                        SizedBox(
                          height: 10.0
                        ),
                        RaisedButton(
                          color: thirdColor,
                          shape: buttonStyle,
                          child: Text(
                              'berechnen',
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate())
                            {
                              _calcMonthlySavigsRate();
                            }
                          }
                        ),
                      ]  
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0
                  ),
                ]
              )
            ),
            SizedBox(
              height: 10.0
            ),
            Card(
              elevation: cardElevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children : <Widget>[
                  ListTile(
                    leading: Icon(Icons.timelapse),
                    title: Text('${money.format(_finalRate)}'),
                    subtitle: Text('solltest du jeden Monat investieren'),
                  ),
                ]
              )
            )
          ]  
        )
      )
    );
  }
}
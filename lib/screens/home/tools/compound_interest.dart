import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// shared
import 'package:easy_finance/shared/constants.dart';

class CompoundInterest extends StatefulWidget {
  @override
  _CompoundInterestState createState() => _CompoundInterestState();
}

class _CompoundInterestState extends State<CompoundInterest> {
  final _formKey = GlobalKey<FormState>();

  double _monthlySavingsRate = 0;
  double _startCapital = 0;
  double _yearsToSave = 0;
  double _interestRate = 0;

  double _total = 0;
  double _interestTotal = 0;
  double _investedCapital = 0;

  var f = new NumberFormat.currency(locale: 'EURO', symbol: '€');

  void _yearlyCompundInterest()
  {
    // reset values
    setState(() {
      _total = 0;
      _interestTotal = 0;
      _investedCapital = 0;
    });

    _investedCapital = _startCapital + (_monthlySavingsRate * _yearsToSave * 12);
    double _capital = _startCapital;

    for(int i = 0; i < _yearsToSave; i++)
    {
      setState(() {
        _capital  += 6.0 * _monthlySavingsRate;
        double _tempInterest = (_capital * _interestRate) / 100;
        _interestTotal += _tempInterest;
        _capital += _tempInterest + 6.0 * _monthlySavingsRate;
      });
    }

    _total = _investedCapital + _interestTotal;

    _investedCapital = num.parse(_investedCapital.toStringAsFixed(2));
    _interestTotal = num.parse(_interestTotal.toStringAsFixed(2));
    _total = num.parse(_total.toStringAsFixed(2));
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
          // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
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
                    'Zinseszins Rechner',
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
                            hintText: 'Monatliche Sparrate in €',
                            labelText: 'Sparrate'
                          ),
                          validator: (value) {
                            if(value.isEmpty || double.tryParse(value) == null)
                            {
                              return 'Bitte füge eine Sparrate hinzu';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _monthlySavingsRate = double.parse(value);
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
                              return 'Bitte füge ein Startkapital hinzu';
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
                          // keyboardType: TextInputType.number,
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
                          shape: buttonStyle,
                          color: thirdColor,
                          child: Text(
                              'berechnen',
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate())
                            {
                              _yearlyCompundInterest();
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
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.euro),
                    title: Text('${f.format(_investedCapital)}'),
                    subtitle: Text('Eingesetztes Kapital')
                  ),
                  ListTile(
                    leading: Icon(Icons.euro),
                    title: Text('${f.format(_interestTotal)}'),
                    subtitle: Text('Zinsertrag')
                  ),
                  ListTile(
                    leading: Icon(Icons.euro),
                    title: Text('${f.format(_total)}'),
                    subtitle: Text('Endkapital')
                  )
                ]
              ),
            ),            
          ]
        )
      )
    );
  }
}
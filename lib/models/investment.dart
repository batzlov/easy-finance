import 'package:easy_finance/screens/home/shared/types.dart';

class Investment {
  final String uid;
  final String name;
  final double growth;
  final double value;
  final double monthlySavingsRate;
  final InvestmentType type;

  Investment({
    this.uid,
    this.name,
    this.growth,
    this.value,
    this.monthlySavingsRate,
    this.type
  });
}
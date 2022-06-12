import 'package:checkingmysales/model/sale.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes{
  static Box<Sale> getTransactions() =>
      Hive.box<Sale>("sales");
}
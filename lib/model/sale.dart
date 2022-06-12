import 'package:hive/hive.dart';

part 'sale.g.dart';

@HiveType(typeId: 0)
class Sale extends HiveObject{

  Sale({required this.amount, required this.month,required this.year});

  
  @HiveField(0)
  late double amount;
  @HiveField(1)
  late double month;
  @HiveField(2)
  late double year;
}
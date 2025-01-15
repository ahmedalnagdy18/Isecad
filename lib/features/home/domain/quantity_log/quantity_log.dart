import 'package:hive/hive.dart';

part 'quantity_log.g.dart';

@HiveType(typeId: 2)
class QuantityLog {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final int soldQuantity;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final double totalPrice; // Add the price field

  QuantityLog({
    required this.productId,
    required this.productName,
    required this.soldQuantity,
    required this.timestamp,
    required this.totalPrice,
  });
}

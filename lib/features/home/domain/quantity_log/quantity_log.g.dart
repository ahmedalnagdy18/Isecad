// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quantity_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuantityLogAdapter extends TypeAdapter<QuantityLog> {
  @override
  final int typeId = 2;

  @override
  QuantityLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuantityLog(
      productId: fields[0] as String,
      productName: fields[1] as String,
      soldQuantity: fields[2] as int,
      timestamp: fields[3] as DateTime,
      totalPrice: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, QuantityLog obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.soldQuantity)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuantityLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

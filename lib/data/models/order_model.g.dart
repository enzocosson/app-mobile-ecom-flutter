// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 1;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      items: (fields[2] as List).cast<CartItemData>(),
      total: fields[3] as double,
      createdAt: fields[4] as DateTime,
      status: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.items)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CartItemDataAdapter extends TypeAdapter<CartItemData> {
  @override
  final int typeId = 2;

  @override
  CartItemData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemData(
      productId: fields[0] as int,
      productTitle: fields[1] as String,
      productPrice: fields[2] as double,
      productThumbnail: fields[3] as String,
      quantity: fields[4] as int,
      productDescription: fields[5] as String,
      productCategory: fields[6] as String,
      productImages: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItemData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productTitle)
      ..writeByte(2)
      ..write(obj.productPrice)
      ..writeByte(3)
      ..write(obj.productThumbnail)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.productDescription)
      ..writeByte(6)
      ..write(obj.productCategory)
      ..writeByte(7)
      ..write(obj.productImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

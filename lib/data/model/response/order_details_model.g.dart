// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderDetailsModelAdapter extends TypeAdapter<OrderDetailsModel> {
  @override
  final int typeId = 0;

  @override
  OrderDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderDetailsModel(
      order: fields[0] as Order,
      details: (fields[1] as List).cast<Details>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderDetailsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.order)
      ..writeByte(1)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 1;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as int,
      tableId: fields[1] as int,
      customerName: fields[6] as String,
      numberOfPeople: fields[2] as int,
      tableOrderId: fields[3] as int,
      orderNote: fields[4] as String,
      orderStatus: fields[5] as String,
      couponDiscountAmount: fields[8] as num?,
      tax: fields[9] as num?,
      extraDiscount: fields[11] as num?,
      deliveryCharge: fields[10] as num?,
    )..table = fields[7] as Table?;
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tableId)
      ..writeByte(2)
      ..write(obj.numberOfPeople)
      ..writeByte(3)
      ..write(obj.tableOrderId)
      ..writeByte(4)
      ..write(obj.orderNote)
      ..writeByte(5)
      ..write(obj.orderStatus)
      ..writeByte(6)
      ..write(obj.customerName)
      ..writeByte(7)
      ..write(obj.table)
      ..writeByte(8)
      ..write(obj.couponDiscountAmount)
      ..writeByte(9)
      ..write(obj.tax)
      ..writeByte(10)
      ..write(obj.deliveryCharge)
      ..writeByte(11)
      ..write(obj.extraDiscount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailsAdapter extends TypeAdapter<Details> {
  @override
  final int typeId = 2;

  @override
  Details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Details(
      id: fields[0] as int?,
      productId: fields[1] as int?,
      orderId: fields[2] as int?,
      price: fields[3] as double?,
      productDetails: fields[4] as ProductDetails?,
      variations: (fields[5] as List?)?.cast<Variation>(),
      oldVariations: (fields[6] as List?)?.cast<OldVariation>(),
      discountOnProduct: fields[7] as double?,
      discountType: fields[8] as String?,
      quantity: fields[9] as int?,
      taxAmount: fields[10] as double?,
      createdAt: fields[11] as String?,
      updatedAt: fields[12] as String?,
      addOnIds: (fields[13] as List?)?.cast<int>(),
      addOnQtys: (fields[14] as List?)?.cast<int>(),
      addOnPrices: (fields[15] as List?)?.cast<double>(),
      addonTaxAmount: fields[16] as double?,
      note: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Details obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.orderId)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.productDetails)
      ..writeByte(5)
      ..write(obj.variations)
      ..writeByte(6)
      ..write(obj.oldVariations)
      ..writeByte(7)
      ..write(obj.discountOnProduct)
      ..writeByte(8)
      ..write(obj.discountType)
      ..writeByte(9)
      ..write(obj.quantity)
      ..writeByte(10)
      ..write(obj.taxAmount)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.addOnIds)
      ..writeByte(14)
      ..write(obj.addOnQtys)
      ..writeByte(15)
      ..write(obj.addOnPrices)
      ..writeByte(16)
      ..write(obj.addonTaxAmount)
      ..writeByte(17)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductDetailsAdapter extends TypeAdapter<ProductDetails> {
  @override
  final int typeId = 3;

  @override
  ProductDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDetails(
      id: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      image: fields[3] as String?,
      price: fields[4] as double?,
      variations: (fields[5] as List?)?.cast<Variations>(),
      addOns: (fields[6] as List?)?.cast<AddOns>(),
      tax: fields[7] as double?,
      availableTimeStarts: fields[8] as String?,
      availableTimeEnds: fields[9] as String?,
      status: fields[10] as int?,
      createdAt: fields[11] as String?,
      updatedAt: fields[12] as String?,
      attributes: (fields[13] as List?)?.cast<String>(),
      categoryIds: (fields[14] as List?)?.cast<CategoryIds>(),
      choiceOptions: (fields[15] as List?)?.cast<ChoiceOptions>(),
      discount: fields[16] as double?,
      discountType: fields[17] as String?,
      taxType: fields[18] as String?,
      setMenu: fields[19] as int?,
      branchId: fields[20] as int?,
      popularityCount: fields[21] as int?,
      productType: fields[22] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDetails obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.variations)
      ..writeByte(6)
      ..write(obj.addOns)
      ..writeByte(7)
      ..write(obj.tax)
      ..writeByte(8)
      ..write(obj.availableTimeStarts)
      ..writeByte(9)
      ..write(obj.availableTimeEnds)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.attributes)
      ..writeByte(14)
      ..write(obj.categoryIds)
      ..writeByte(15)
      ..write(obj.choiceOptions)
      ..writeByte(16)
      ..write(obj.discount)
      ..writeByte(17)
      ..write(obj.discountType)
      ..writeByte(18)
      ..write(obj.taxType)
      ..writeByte(19)
      ..write(obj.setMenu)
      ..writeByte(20)
      ..write(obj.branchId)
      ..writeByte(21)
      ..write(obj.popularityCount)
      ..writeByte(22)
      ..write(obj.productType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariationsAdapter extends TypeAdapter<Variations> {
  @override
  final int typeId = 4;

  @override
  Variations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Variations(
      type: fields[0] as String?,
      price: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Variations obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddOnsAdapter extends TypeAdapter<AddOns> {
  @override
  final int typeId = 5;

  @override
  AddOns read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddOns(
      id: fields[0] as int?,
      name: fields[1] as String?,
      price: fields[2] as double?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
      translations: (fields[5] as List?)?.cast<void>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddOns obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.translations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddOnsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryIdsAdapter extends TypeAdapter<CategoryIds> {
  @override
  final int typeId = 6;

  @override
  CategoryIds read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryIds(
      id: fields[0] as String?,
      position: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryIds obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryIdsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChoiceOptionsAdapter extends TypeAdapter<ChoiceOptions> {
  @override
  final int typeId = 7;

  @override
  ChoiceOptions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChoiceOptions(
      name: fields[0] as String?,
      title: fields[1] as String?,
      options: (fields[2] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChoiceOptions obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceOptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TableAdapter extends TypeAdapter<Table> {
  @override
  final int typeId = 8;

  @override
  Table read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Table(
      id: fields[0] as int?,
      number: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Table obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariationAdapter extends TypeAdapter<Variation> {
  @override
  final int typeId = 9;

  @override
  Variation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Variation(
      name: fields[0] as String?,
      min: fields[1] as int?,
      max: fields[2] as int?,
      isRequired: fields[3] as bool?,
      variationValues: (fields[5] as List?)?.cast<VariationValue>(),
      isMultiSelect: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Variation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.min)
      ..writeByte(2)
      ..write(obj.max)
      ..writeByte(3)
      ..write(obj.isRequired)
      ..writeByte(4)
      ..write(obj.isMultiSelect)
      ..writeByte(5)
      ..write(obj.variationValues);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariationValueAdapter extends TypeAdapter<VariationValue> {
  @override
  final int typeId = 10;

  @override
  VariationValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VariationValue(
      level: fields[0] as String?,
      optionPrice: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, VariationValue obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.optionPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariationValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OldVariationAdapter extends TypeAdapter<OldVariation> {
  @override
  final int typeId = 11;

  @override
  OldVariation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OldVariation();
  }

  @override
  void write(BinaryWriter writer, OldVariation obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OldVariationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

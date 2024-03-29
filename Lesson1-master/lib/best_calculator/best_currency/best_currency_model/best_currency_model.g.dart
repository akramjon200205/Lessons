// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_currency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BestCurrencyModelAdapter extends TypeAdapter<BestCurrencyModel> {
  @override
  final int typeId = 0;

  @override
  BestCurrencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BestCurrencyModel(
      id: fields[0] as int?,
      code: fields[1] as String?,
      ccy: fields[2] as String?,
      ccyNmRu: fields[3] as String?,
      ccyNmUz: fields[4] as String?,
      ccyNmUzc: fields[5] as String?,
      ccyNmEn: fields[6] as String?,
      nominal: fields[7] as String?,
      rate: fields[8] as String?,
      diff: fields[9] as String?,
      date: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BestCurrencyModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.ccy)
      ..writeByte(3)
      ..write(obj.ccyNmRu)
      ..writeByte(4)
      ..write(obj.ccyNmUz)
      ..writeByte(5)
      ..write(obj.ccyNmUzc)
      ..writeByte(6)
      ..write(obj.ccyNmEn)
      ..writeByte(7)
      ..write(obj.nominal)
      ..writeByte(8)
      ..write(obj.rate)
      ..writeByte(9)
      ..write(obj.diff)
      ..writeByte(10)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BestCurrencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

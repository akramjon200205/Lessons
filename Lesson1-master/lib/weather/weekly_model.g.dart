// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyModelAdapter extends TypeAdapter<WeeklyModel> {
  @override
  final int typeId = 2;

  @override
  WeeklyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyModel(
      day: fields[0] as String?,
      date: fields[1] as String?,
      temp: fields[2] as String?,
      desc: fields[3] as String?,
      rainPer: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.temp)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.rainPer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

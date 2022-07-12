// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 1;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      temp: fields[0] as String?,
      rain: fields[1] as String?,
      wind: fields[2] as String?,
      pess: fields[3] as String?,
      moon: fields[4] as String?,
      sun: fields[5] as String?,
      sunset: fields[6] as String?,
      tempNight: fields[7] as String?,
      curDay: fields[8] as String?,
      desc: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.temp)
      ..writeByte(1)
      ..write(obj.rain)
      ..writeByte(2)
      ..write(obj.wind)
      ..writeByte(3)
      ..write(obj.pess)
      ..writeByte(4)
      ..write(obj.moon)
      ..writeByte(5)
      ..write(obj.sun)
      ..writeByte(6)
      ..write(obj.sunset)
      ..writeByte(7)
      ..write(obj.tempNight)
      ..writeByte(8)
      ..write(obj.curDay)
      ..writeByte(9)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

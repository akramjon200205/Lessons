import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 2)
class WeatherModel extends HiveObject {
  @HiveField(0)
  String? temp;
  @HiveField(1)
  String? rain;
  @HiveField(2)
  String? wind;
  @HiveField(3)
  String? pess;
  @HiveField(4)
  String? moon;
  @HiveField(5)
  String? sun;
  @HiveField(6)
  String? sunset;
  @HiveField(7)
  String? tempNight;
  @HiveField(8)
  String? curDay;
  @HiveField(9)
  String? desc;

  WeatherModel({
    this.temp,
    this.rain,
    this.wind,
    this.pess,
    this.moon,
    this.sun,
    this.sunset,
    this.tempNight,
    this.curDay,
    this.desc,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    rain = json['rain'];
    wind = json['wind'];
    pess = json['pess'];
    moon = json['moon'];
    sun = json['sun'];
    sunset = json['sunset'];
    tempNight = json['tempNight'];
    curDay = json['curDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['temp'] = temp;
    data['rain'] = rain;
    data['wind'] = wind;
    data['pess'] = pess;
    data['moon'] = moon;
    data['sun'] = sun;
    data['sunset'] = sunset;
    data['tempNight'] = tempNight;
    data['curDay'] = curDay;

    return data;
  }
}

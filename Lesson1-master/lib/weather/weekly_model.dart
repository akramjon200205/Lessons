import 'package:hive/hive.dart';

part 'weekly_model.g.dart';

@HiveType(typeId: 3)
class WeeklyModel extends HiveObject {
  @HiveField(0)
  String? day;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? temp;
  @HiveField(3)
  String? desc;
  @HiveField(4)
  String? rainPer;

  WeeklyModel({
    this.day,
    this.date,
    this.temp,
    this.desc,
    this.rainPer,
  });

  WeeklyModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    temp = json['temp'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['temp'] = temp;
    data['temp'] = temp;
    data['desc'] = desc;

    return data;
  }
}

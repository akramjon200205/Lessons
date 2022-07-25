import 'package:hive/hive.dart';

part 'best_currency_model.g.dart';

@HiveType(typeId: 0)
class BestCurrencyModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  String? ccy;
  @HiveField(3)
  String? ccyNmRu;
  @HiveField(4)
  String? ccyNmUz;
  @HiveField(5)
  String? ccyNmUzc;
  @HiveField(6)
  String? ccyNmEn;
  @HiveField(7)
  String? nominal;
  @HiveField(8)
  String? rate;
  @HiveField(9)
  String? diff;
  @HiveField(10)
  String? date;

  BestCurrencyModel({
    this.id,
    this.code,
    this.ccy,
    this.ccyNmRu,
    this.ccyNmUz,
    this.ccyNmUzc,
    this.ccyNmEn,
    this.nominal,
    this.rate,
    this.diff,
    this.date,
  });

  @override
  String toString() {
    return 'BestCurrencyModel(id: $id, code: $code, ccy: $ccy, ccyNmRu: $ccyNmRu, ccyNmUz: $ccyNmUz, ccyNmUzc: $ccyNmUzc, ccyNmEn: $ccyNmEn, nominal: $nominal, rate: $rate, diff: $diff, date: $date)';
  }

  factory BestCurrencyModel.fromJson(Map<String, dynamic> json) => BestCurrencyModel(
        id: json['id'] as int?,
        code: json['Code'] as String?,
        ccy: json['Ccy'] as String?,
        ccyNmRu: json['CcyNm_RU'] as String?,
        ccyNmUz: json['CcyNm_UZ'] as String?,
        ccyNmUzc: json['CcyNm_UZC'] as String?,
        ccyNmEn: json['CcyNm_EN'] as String?,
        nominal: json['Nominal'] as String?,
        rate: json['Rate'] as String?,
        diff: json['Diff'] as String?,
        date: json['Date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'Code': code,
        'Ccy': ccy,
        'CcyNm_RU': ccyNmRu,
        'CcyNm_UZ': ccyNmUz,
        'CcyNm_UZC': ccyNmUzc,
        'CcyNm_EN': ccyNmEn,
        'Nominal': nominal,
        'Rate': rate,
        'Diff': diff,
        'Date': date,
      };

  BestCurrencyModel copyWith({
    int? id,
    String? code,
    String? ccy,
    String? ccyNmRu,
    String? ccyNmUz,
    String? ccyNmUzc,
    String? ccyNmEn,
    String? nominal,
    String? rate,
    String? diff,
    String? date,
  }) {
    return BestCurrencyModel(
      id: id ?? this.id,
      code: code ?? this.code,
      ccy: ccy ?? this.ccy,
      ccyNmRu: ccyNmRu ?? this.ccyNmRu,
      ccyNmUz: ccyNmUz ?? this.ccyNmUz,
      ccyNmUzc: ccyNmUzc ?? this.ccyNmUzc,
      ccyNmEn: ccyNmEn ?? this.ccyNmEn,
      nominal: nominal ?? this.nominal,
      rate: rate ?? this.rate,
      diff: diff ?? this.diff,
      date: date ?? this.date,
    );
  }
}

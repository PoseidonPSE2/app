class Bottle {
  final int id;
  final int userId;
  final String nfcId;
  final int fillVolume;
  final String waterType;
  final String title;
  final String? pathImage;
  final bool active;
  final List<dynamic>? waterTransactions;

  Bottle({
    required this.id,
    required this.userId,
    required this.nfcId,
    required this.fillVolume,
    required this.waterType,
    required this.title,
    this.pathImage,
    required this.active,
    this.waterTransactions,
  });

  factory Bottle.fromJson(Map<String, dynamic> json) {
    return Bottle(
      id: json['ID'] as int,
      userId: json['UserID'] as int,
      nfcId: json['NFCID'] as String,
      fillVolume: json['FillVolume'] as int,
      waterType: json['WaterType'] as String,
      title: json['Title'] as String,
      pathImage: json['PathImage'] as String?,
      active: json['Active'] as bool,
      waterTransactions: json['WaterTransactions'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'UserID': userId,
      'NFCID': nfcId,
      'FillVolume': fillVolume,
      'WaterType': waterType,
      'Title': title,
      'PathImage': pathImage,
      'Active': active,
      'WaterTransactions': waterTransactions,
    };
  }
}

class Bottle {
  final int? id;
  final int userId;
  final String? nfcId;
  final int fillVolume;
  final String waterType;
  final String title;
  final String? pathImage;
  final bool? active;
  final List<dynamic>? waterTransactions;

  Bottle({
    this.id,
    required this.userId,
    this.nfcId,
    required this.fillVolume,
    required this.waterType,
    required this.title,
    this.pathImage,
    this.active,
    this.waterTransactions,
  });

  factory Bottle.fromJson(Map<String, dynamic> json) {
    return Bottle(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      nfcId: json['NFCID'],
      fillVolume: json['fill_volume'] as int,
      waterType: json['water_type'] as String,
      title: json['title'] as String,
      pathImage: json['bottle_image'] as String?,
      active: json['active'] as bool,
      waterTransactions: json['water_transactions'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'NFCID': nfcId,
      'fill_volume': fillVolume,
      'water_type': waterType,
      'title': title,
      'bottle_image': pathImage,
      'active': active,
      'water_transactions': waterTransactions,
    };
  }
}

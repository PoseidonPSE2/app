class Bottle {
  final int? chipId;
  final double fillVolume;
  final String waterType;
  final List<int>? pathImage;
  final String title;
  final String hardwareID;
  final int? userId;

  Bottle(
      {this.chipId,
      required this.fillVolume,
      required this.waterType,
      this.pathImage,
      required this.title,
      required this.hardwareID,
      this.userId});

  factory Bottle.fromJson(Map<String, dynamic> json) {
    return Bottle(
      chipId: json['chipId'] as int,
      fillVolume: json['fillVolume'] as double,
      waterType: json['waterType'] as String,
      pathImage: json['pathImage'] as List<int>,
      title: json['title'] as String,
      hardwareID: json['tagHardwareId'] as String,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chipId': chipId,
      'fillVolume': fillVolume.round(),
      'waterType': waterType,
      'pathImage': pathImage,
      'title': title,
      'hardwareID': hardwareID,
      'userId': userId,
    };
  }
}

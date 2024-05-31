import 'package:flutter/cupertino.dart';
import 'package:hello_worl2/restApi/waterEnums.dart';

class RefillStation {
  final int id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final int? likeCounter;
  final String waterSource;
  final String openingTimes;
  final bool active;
  final WaterStationType type;
  final OfferedWatertype offeredWatertype;

  RefillStation({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.likeCounter,
    required this.waterSource,
    required this.openingTimes,
    required this.active,
    required this.type,
    required this.offeredWatertype,
  }) : super();

  factory RefillStation.fromJson(Map<String, dynamic> json) {
    return RefillStation(
      id: json['ID'] as int,
      name: json['Name'] as String,
      description: json['Description'] as String,
      latitude: json['Latitude'] as double,
      longitude: json['Longitude'] as double,
      address: json['Address'] as String,
      likeCounter: json['Likes'] != null ? json['Likes'] as int : 0,
      waterSource: json['WaterSource'] as String,
      openingTimes: json['OpeningTimes'] as String,
      active: json['Active'] as bool,
      type: getWaterStationType(json['Type']as String),
      offeredWatertype: getOfferedWatertype(json['OfferedWaterTypes']as String),
    );
  }
  static final Widget markerChild = Container(
    child: Container(
      child: Image.asset('assets/image/frontpage.png'),
    ),
  );

  Widget get child => markerChild;
}

class RefillStationMarker {
  final int id;
  final double longitude;
  final double latitude;
  final bool status;

  RefillStationMarker({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.status,
  }): super();

  factory RefillStationMarker.fromJson(Map<String, dynamic> json) {
    return RefillStationMarker(
      id: json['id'] as int,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      status: json['status'] as bool,
    );
  }

  static final Widget markerChild = Container(
    child: Container(
      child: Image.asset('assets/image/frontpage.png'),
    ),
  );

  Widget get child => markerChild;
}

class RefillstationReview {
  final int averageCleannessRating;
  final int averageAccesibilityRating;
  final int averageWaterQualityRating;

  RefillstationReview({
    required this.averageCleannessRating,
    required this.averageAccesibilityRating,
    required this.averageWaterQualityRating,
  });

  factory RefillstationReview.fromJson(Map<String, dynamic> json) {
    return RefillstationReview(
      averageCleannessRating: json['averageCleannessRating'] as int,
      averageAccesibilityRating: json['averageAccesibilityRating'] as int,
      averageWaterQualityRating: json['averageWaterQualityRating'] as int,
    );
  }
}

class RefillstationProblem {
  final int stationID;
  final String title;
  final String description;
  //final List<int>? mediaLink;
  final String status;

  RefillstationProblem({
    required this.stationID,
    required this.title,
    required this.description,
    required this.status,
    //this.mediaLink,
  });

  factory RefillstationProblem.fromJson(Map<String, dynamic> json) {
    return RefillstationProblem(
      stationID: json['refillstationId'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      //mediaLink: json['mediaLink'] as List<int>,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'stationID': stationID,
        'title': title,
        'description': description,
        'status': status, // Convert enum to string
        //'mediaLink': mediaLink,
      };
}

class ContributionKL {
  final int amountRefillStationSmart;
  final int amountRefillStationManual;

  ContributionKL({
    required this.amountRefillStationSmart,
    required this.amountRefillStationManual,
  });

  factory ContributionKL.fromJson(Map<String, dynamic> json) {
    return ContributionKL(
      amountRefillStationSmart: json['amountRefillStationSmart'] as int,
      amountRefillStationManual: json['amountRefillStationManual'] as int,
    );
  }
}

class RefillstationLike {
  final bool isLiked;

  RefillstationLike({
    required this.isLiked,
  });

  factory RefillstationLike.fromJson(Map<String, dynamic> json) {
    return RefillstationLike(
      isLiked: json['isLiked'] as bool,
    );
  }
}

class Contribution {
  final int amountFillings;
  final double savedMoney;
  final double savedTrash;
  final double amountWater;

  Contribution({
    required this.amountFillings,
    required this.savedMoney,
    required this.savedTrash,
    required this.amountWater,
  });

  factory Contribution.fromJson(Map<String, dynamic> json) {
    return Contribution(
      amountFillings: json['amountFillings'] as int,
      savedMoney: json['savedMoney'] as double,
      savedTrash: json['savedTrash'] as double,
      amountWater: json['amountWater'] as double,
    );
  }
}

class ConsumerTestQuestion {
  final int testQuestionId;
  final String questionText;
  final int minValue;
  final int maxValue;

  ConsumerTestQuestion({
    required this.testQuestionId,
    required this.questionText,
    required this.minValue,
    required this.maxValue,
  });

  factory ConsumerTestQuestion.fromJson(Map<String, dynamic> json) {
    return ConsumerTestQuestion(
      testQuestionId: json['testQuestionId'] as int,
      questionText: json['questionText'] as String,
      minValue: json['minValue'] as int,
      maxValue: json['maxValue'] as int,
    );
  }
}

class ConsumerTestAverage {
  final int testQuestionId;
  final double averageAnswer;

  ConsumerTestAverage({
    required this.testQuestionId,
    required this.averageAnswer,
  });

  factory ConsumerTestAverage.fromJson(Map<String, dynamic> json) {
    return ConsumerTestAverage(
      testQuestionId: json['testQuestionId'] as int,
      averageAnswer: json['averageAnswer'] as double,
    );
  }
}

class Bottle {
  final int chipId;
  final double fillVolume;
  final WaterStationType waterType;
  final List<int>? pathImage;
  final String title;
  final String tagHardwareId;

  Bottle(
      {required this.chipId,
      required this.fillVolume,
      required this.waterType,
      this.pathImage,
      required this.title,
      required this.tagHardwareId});

  factory Bottle.fromJson(Map<String, dynamic> json) {
    return Bottle(
      chipId: json['chipId'] as int,
      fillVolume: json['fillVolume'] as double,
      waterType: json['waterType'] as WaterStationType,
      pathImage: json['pathImage'] as List<int>,
      title: json['title'] as String,
      tagHardwareId: json['tagHardwareId'] as String,
    );
  }
}

class ConsumerTestAnswer {
  final int testQuestionId;
  final int userId;
  final int answer;

  ConsumerTestAnswer({
    required this.testQuestionId,
    required this.userId,
    required this.answer,
  });

  factory ConsumerTestAnswer.fromJson(Map<String, dynamic> json) {
    return ConsumerTestAnswer(
      testQuestionId: json['testQuestionId'] as int,
      userId: json['userId'] as int,
      answer: json['answer'] as int,
    );
  }
}

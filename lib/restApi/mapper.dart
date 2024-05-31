import 'package:hello_worl2/restApi/waterEnums.dart';

class RefillStation {
  final int id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final int likeCounter;
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
    required this.likeCounter,
    required this.waterSource,
    required this.openingTimes,
    required this.active,
    required this.type,
    required this.offeredWatertype,
  });

  factory RefillStation.fromJson(Map<String, dynamic> json) {
    return RefillStation(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      address: json['address'] as String,
      likeCounter: json['likeCounter'] as int,
      waterSource: json['waterSource'] as String,
      openingTimes: json['openingTimes'] as String,
      active: json['active'] as bool,
      type: json['type'] as WaterStationType,
      offeredWatertype: json['offeredWatertype'] as OfferedWatertype,
    );
  }
}

class RefillStationMarker {
  final int id;
  final double longitude;
  final double latitude;
  final String status;

  RefillStationMarker({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.status,
  });

  factory RefillStationMarker.fromJson(Map<String, dynamic> json) {
    return RefillStationMarker(
      id: json['id'] as int,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      status: json['status'] as String,
    );
  }
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
  final int refillstationId;
  final String title;
  final String description;
  final List<int> mediaLink;

  RefillstationProblem({
    required this.refillstationId,
    required this.title,
    required this.description,
    required this.mediaLink,
  });

  factory RefillstationProblem.fromJson(Map<String, dynamic> json) {
    return RefillstationProblem(
      refillstationId: json['refillstationId'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      mediaLink: json['mediaLink'] as List<int>,
    );
  }
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

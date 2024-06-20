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
  final int stationId;
  final int userId;

  RefillstationLike({required this.stationId, required this.userId});

  Map<String, dynamic> toJson() => {
        'station_id': stationId,
        'user_id': userId,
      };
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

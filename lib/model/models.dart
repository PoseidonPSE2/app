class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;
  final String topic;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.topic,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      questions: List<Question>.from(
          json['questions'].map((q) => Question.fromJson(q))),
      topic: json['topic'],
    );
  }
}

class Question {
  final String text;
  final List<Option> options;

  Question({
    required this.text,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      options:
          List<Option>.from(json['options'].map((o) => Option.fromJson(o))),
    );
  }
}

class Option {
  final String value;
  final bool correct;
  final String detail;

  Option({
    required this.value,
    required this.correct,
    required this.detail,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      value: json['value'],
      correct: json['correct'],
      detail: json['detail'],
    );
  }
}

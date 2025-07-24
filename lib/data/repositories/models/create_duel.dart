import 'dart:convert';

CreateDuel createDuelFromJson(String str) =>
    CreateDuel.fromJson(json.decode(str));

String createDuelToJson(CreateDuel data) => json.encode(data.toJson());

class CreateDuel {
  final String imagePath;
  final String question;
  final DateTime deadline;

  CreateDuel({
    required this.imagePath,
    required this.question,
    required this.deadline,
  });

  factory CreateDuel.fromJson(Map<String, dynamic> json) {
    return CreateDuel(
      imagePath: json["imagePath"],
      question: json["question"],
      deadline: json["deadline"],
    );
  }

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "question": question,
    "deadline": deadline,
  };

  @override
  String toString() {
    return 'CreateDuel(imagePath: $imagePath, question: $question, deadline: $deadline)';
  }
}

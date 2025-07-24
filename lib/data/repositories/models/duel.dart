import 'dart:convert';

abstract class BaseDuelModel {}

CreateDuelModel createDuelModelFromJson(String str) =>
    CreateDuelModel.fromJson(json.decode(str));

String createDuelToJson(CreateDuelModel data) => json.encode(data.toJson());

class CreateDuelModel extends BaseDuelModel {
  final String imagePath;
  final String question;
  final DateTime deadline;

  CreateDuelModel({
    required this.imagePath,
    required this.question,
    required this.deadline,
  });

  factory CreateDuelModel.fromJson(Map<String, dynamic> json) {
    return CreateDuelModel(
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
    return 'CreateDuelModel(imagePath: $imagePath, question: $question, deadline: $deadline)';
  }
}

DuelModel duelModelFromJson(String str) => DuelModel.fromJson(json.decode(str));

String duelModelToJson(DuelModel data) => json.encode(data.toJson());

class DuelModel extends BaseDuelModel {
  final String approvedBy;
  final String bgUrl;
  final String cancellationReason;
  final int commission;
  final DateTime createdAt;
  final DateTime deadline;
  final DuelInfo duelInfo;
  final int duelPrice;
  final String duelType;
  final List<int> entities;
  final DateTime eventDate;
  final int? finalResult;
  final String id;
  final String imageUrl;
  final bool joined;
  final int noCount;
  final String ownerId;
  final int paymentType;
  final int playerStatus;
  final int playersCount;
  final String question;
  final int refundedPlayersCount;
  final String resolvedBy;
  final int roomNumber;
  final String sourceOfTruth;
  final int status;
  final String subtopic;
  final String topic;
  final String tournamentId;
  final DateTime updatedAt;
  final String username;
  final int winnersCount;
  final int yesCount;
  final int? yourAnswer;

  DuelModel({
    required this.approvedBy,
    required this.bgUrl,
    required this.cancellationReason,
    required this.commission,
    required this.createdAt,
    required this.deadline,
    required this.duelInfo,
    required this.duelPrice,
    required this.duelType,
    required this.entities,
    required this.eventDate,
    required this.finalResult,
    required this.id,
    required this.imageUrl,
    required this.joined,
    required this.noCount,
    required this.ownerId,
    required this.paymentType,
    required this.playerStatus,
    required this.playersCount,
    required this.question,
    required this.refundedPlayersCount,
    required this.resolvedBy,
    required this.roomNumber,
    required this.sourceOfTruth,
    required this.status,
    required this.subtopic,
    required this.topic,
    required this.tournamentId,
    required this.updatedAt,
    required this.username,
    required this.winnersCount,
    required this.yesCount,
    required this.yourAnswer,
  });

  factory DuelModel.fromJson(Map<String, dynamic> json) {
    return DuelModel(
      approvedBy: json["approved_by"] ?? "",
      bgUrl: json["bg_url"] ?? "",
      cancellationReason: json["cancellation_reason"] ?? "",
      commission: json["commission"] ?? 0,
      createdAt: DateTime.parse(json["created_at"]),
      deadline: DateTime.parse(json["deadline"]),
      duelInfo: DuelInfo.fromJson(json['duel_info']),
      duelPrice: json["duel_price"] ?? 0,
      duelType: json["duel_type"] ?? "",
      entities: List<int>.from(json["entities"] ?? []),
      eventDate: DateTime.parse(json["event_date"]),
      finalResult: json["final_result"] ?? 0,
      id: json["id"] ?? "",
      imageUrl: json["image_url"] ?? "",
      joined: json["joined"] ?? false,
      noCount: json["no_count"] ?? 0,
      ownerId: json["owner_id"] ?? "",
      paymentType: json["payment_type"] ?? 0,
      playerStatus: json["player_status"] ?? 0,
      playersCount: json["players_count"] ?? 0,
      question: json["question"] ?? "",
      refundedPlayersCount: json["refunded_players_count"] ?? 0,
      resolvedBy: json["resolved_by"] ?? "",
      roomNumber: json["room_number"] ?? 0,
      sourceOfTruth: json["source_of_truth"] ?? "",
      status: json["status"] ?? 0,
      subtopic: json["subtopic"] ?? "",
      topic: json["topic"] ?? "",
      tournamentId: json["tournament_id"] ?? "",
      updatedAt: DateTime.parse(json["updated_at"]),
      username: json["username"] ?? "",
      winnersCount: json["winners_count"] ?? 0,
      yesCount: json["yes_count"] ?? 0,
      yourAnswer: json["your_answer"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "approved_by": approvedBy,
    "bg_url": bgUrl,
    "cancellation_reason": cancellationReason,
    "commission": commission,
    "created_at": createdAt.toIso8601String(),
    "deadline": deadline.toIso8601String(),
    "duel_info": duelInfo,
    "duel_price": duelPrice,
    "duel_type": duelType,
    "entities": entities,
    "event_date": eventDate,
    "final_result": finalResult,
    "id": id,
    "image_url": imageUrl,
    "joined": joined,
    "no_count": noCount,
    "owner_id": ownerId,
    "payment_type": paymentType,
    "player_status": playerStatus,
    "players_count": playersCount,
    "question": question,
    "refunded_players_count": refundedPlayersCount,
    "resolved_by": resolvedBy,
    "room_number": roomNumber,
    "source_of_truth": sourceOfTruth,
    "status": status,
    "subtopic": subtopic,
    "topic": topic,
    "tournament_id": tournamentId,
    "updated_at": updatedAt,
    "username": username,
    "winners_count": winnersCount,
    "yes_count": yesCount,
    "your_answer": yourAnswer,
  };

  factory DuelModel.demoData() {
    return DuelModel(
      approvedBy: "00000000-0000-0000-0000-000000000000",
      bgUrl: "/admin_uploads/dcaaa068-ddad-11ef-bc5b-0242ac140005.png",
      cancellationReason: "",
      commission: 0,
      createdAt: DateTime.parse("2025-07-24T00:00:00.456358Z"),
      deadline: DateTime.parse("2025-08-27T00:00:00Z"),
      duelInfo: DuelInfo(coinId: 5426, direction: 1, targetPrice: 110),
      duelPrice: 1000,
      duelType: "",
      entities: [],
      eventDate: DateTime.parse("2025-08-27T00:00:00Z"),
      finalResult: null,
      id: "fb3c6bd1-3435-4f8b-bcc1-8a995ac1654b",
      imageUrl: "/admin_uploads/dc88e008-ddad-11ef-bc5b-0242ac140005.png",
      joined: false,
      noCount: 95,
      ownerId: "914a26d1-c283-4a4f-8d2e-013c20485e03",
      paymentType: 0,
      playerStatus: 0,
      playersCount: 212,
      question: "Will Pepe ETF approved in 2025?\n",
      refundedPlayersCount: 0,
      resolvedBy: "00000000-0000-0000-0000-000000000000",
      roomNumber: 0,
      sourceOfTruth: "g.m",
      status: 4,
      subtopic: "Crypto",
      topic: "custom",
      tournamentId: "00000000-0000-0000-0000-000000000000",
      updatedAt: DateTime.parse("2025-07-23T00:00:00Z"),
      username: "hi",
      winnersCount: 0,
      yesCount: 117,
      yourAnswer: null,
    );
  }

  @override
  String toString() {
    return 'DuelModel(id: $id, question: $question, status: $status, deadline: $deadline)';
  }
}

class DuelInfo {
  final int coinId;
  final int direction;
  final num targetPrice;

  DuelInfo({
    required this.coinId,
    required this.direction,
    required this.targetPrice,
  });

  factory DuelInfo.fromJson(Map<String, dynamic> json) {
    return DuelInfo(
      coinId: json['coin_id'] ?? 0,
      direction: json['direction'] ?? 0,
      targetPrice: json['target_price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'coin_id': coinId,
    'direction': direction,
    'target_price': targetPrice,
  };

  @override
  String toString() =>
      'DuelInfo(coinId: $coinId, direction: $direction, targetPrice: $targetPrice)';
}

import 'dart:convert';

abstract class BaseDuelModel {}

CreateDuelModel createDuelModelFromJson(String str) =>
    CreateDuelModel.fromJson(json.decode(str));

String createDuelToJson(CreateDuelModel data) => json.encode(data.toJson());

class CreateDuelModel extends BaseDuelModel {
  final int? answer;
  final String? bgUrl;
  final int? commission;
  final DateTime? deadline;
  final DuelInfo? duelInfo;
  final int? duelPrice;
  final String? duelType;
  final List<int>? entities;
  final DateTime? eventDate;
  final String? imageUrl;
  final bool? isAppDuel;
  final bool? isOwnerResolving; // You - true, duel duck - false
  final int? paymentType; // 0 duck coin, 1 usdc
  final String? question;
  final String? sourceOfTruth; // link
  final String? subtopic;
  final String? topic;
  final String? tournamentId;

  CreateDuelModel({
    this.answer,
    this.bgUrl,
    this.commission,
    this.deadline,
    this.duelInfo,
    this.duelPrice,
    this.duelType,
    this.entities,
    this.eventDate,
    this.imageUrl,
    this.isAppDuel = true,
    this.isOwnerResolving,
    this.paymentType = 1, // 0 duck coin, 1 usdc
    this.question,
    this.sourceOfTruth,
    this.subtopic,
    this.topic = "custom",
    this.tournamentId,
  });

  CreateDuelModel copyWith({
    int? answer,
    String? bgUrl,
    int? commission,
    DateTime? deadline,
    DuelInfo? duelInfo,
    int? duelPrice,
    String? duelType,
    List<int>? entities,
    DateTime? eventDate,
    String? imageUrl,
    bool? isAppDuel,
    bool? isOwnerResolving, // You - true, duel duck - false
    int? paymentType, // 0 duck coin, 1 usdc
    String? question,
    String? sourceOfTruth, // link
    String? subtopic,
    String? topic,
    String? tournamentId,
  }) => CreateDuelModel(
    answer: answer ?? this.answer,
    bgUrl: bgUrl ?? this.bgUrl,
    commission: commission ?? this.commission,
    deadline: deadline ?? this.deadline,
    duelInfo: duelInfo ?? this.duelInfo,
    duelPrice: duelPrice ?? this.duelPrice,
    duelType: duelType ?? this.duelType,
    entities: entities ?? this.entities,
    eventDate: eventDate ?? this.eventDate,
    imageUrl: imageUrl ?? this.imageUrl,
    isAppDuel: isAppDuel ?? this.isAppDuel,
    isOwnerResolving: isOwnerResolving ?? this.isOwnerResolving,
    paymentType: paymentType ?? this.paymentType,
    question: question ?? this.question,
    sourceOfTruth: sourceOfTruth ?? this.sourceOfTruth,
    subtopic: subtopic ?? this.subtopic,
    topic: topic ?? this.topic,
    tournamentId: tournamentId ?? this.tournamentId,
  );

  factory CreateDuelModel.fromJson(Map<String, dynamic> json) {
    return CreateDuelModel(
      answer: json["answer"],
      bgUrl: json["bg_url"] ?? "",
      commission: json["commission"] ?? 0,
      deadline: DateTime.tryParse(json["deadline"] ?? "") ?? DateTime.now(),
      duelInfo:
          json['duel_info'] != null
              ? DuelInfo.fromJson(json['duel_info'])
              : null,
      duelPrice: json["duel_price"] ?? 0,
      duelType: json["duel_type"] ?? "",
      entities: List<int>.from(json["entities"] ?? []),
      eventDate: DateTime.tryParse(json["event_date"] ?? "") ?? DateTime.now(),
      imageUrl: json["image_url"] ?? "",
      isAppDuel: json["is_app_duel"] ?? false,
      isOwnerResolving: json["is_owner_resolving"] ?? false,
      paymentType: json["payment_type"] ?? 0,
      question: json["question"] ?? "",
      sourceOfTruth: json["source_of_truth"] ?? "",
      subtopic: json["subtopic"] ?? "",
      topic: json["topic"] ?? "",
      tournamentId: json["tournament_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "answer": answer,
    "bg_url": bgUrl,
    "commission": commission,
    "deadline": "${deadline!.toIso8601String()}Z",
    "duel_info": duelInfo?.toJson(),
    "duel_price": duelPrice,
    "duel_type": duelType,
    "entities": entities,
    "event_date": "${eventDate!.toIso8601String()}Z",
    "image_url": imageUrl,
    "is_app_duel": isAppDuel,
    "is_owner_resolving": isOwnerResolving,
    "payment_type": paymentType,
    "question": question,
    "source_of_truth": sourceOfTruth,
    "subtopic": subtopic,
    "topic": topic,
    "tournament_id": tournamentId,
  };

  @override
  String toString() {
    return 'CreateDuelModel(question: $question, deadline: $deadline, duelType: $duelType)';
  }
}

DuelModel duelModelFromJson(String str) => DuelModel.fromJson(json.decode(str));

String duelModelToJson(DuelModel data) => json.encode(data.toJson());

class DuelModel extends BaseDuelModel {
  final String? approvedBy;
  final String? bgUrl;
  final String? cancellationReason;
  final int commission;
  final DateTime? createdAt;
  final DateTime? deadline;
  final DuelInfo? duelInfo;
  final int duelPrice;
  final String? duelType;
  final List<int>? entities;
  final DateTime? eventDate;
  final int? finalResult;
  final String id;
  final String? imageUrl;
  final bool? joined;
  final int noCount;
  final String? ownerId;
  final int? paymentType;
  final int? playerStatus;
  final int playersCount;
  final String question;
  final int? refundedPlayersCount;
  final String resolvedBy;
  final int? roomNumber;
  final String? sourceOfTruth;
  final int? status;
  final String? subtopic;
  final String? topic;
  final String? tournamentId;
  final DateTime? updatedAt;
  final String? username;
  final int? winnersCount;
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

  DuelModel copyWith({
    String? approvedBy,
    String? bgUrl,
    String? cancellationReason,
    int? commission,
    DateTime? createdAt,
    DateTime? deadline,
    DuelInfo? duelInfo,
    int? duelPrice,
    String? duelType,
    List<int>? entities,
    DateTime? eventDate,
    int? finalResult,
    String? id,
    String? imageUrl,
    bool? joined,
    int? noCount,
    String? ownerId,
    int? paymentType,
    int? playerStatus,
    int? playersCount,
    String? question,
    int? refundedPlayersCount,
    String? resolvedBy,
    int? roomNumber,
    String? sourceOfTruth,
    int? status,
    String? subtopic,
    String? topic,
    String? tournamentId,
    DateTime? updatedAt,
    String? username,
    int? winnersCount,
    int? yesCount,
    int? yourAnswer,
  }) => DuelModel(
    approvedBy: approvedBy ?? this.approvedBy,
    bgUrl: bgUrl ?? this.bgUrl,
    cancellationReason: cancellationReason ?? this.cancellationReason,
    commission: commission ?? this.commission,
    createdAt: createdAt ?? this.createdAt,
    deadline: deadline ?? this.deadline,
    duelInfo: duelInfo ?? this.duelInfo,
    duelPrice: duelPrice ?? this.duelPrice,
    duelType: duelType ?? this.duelType,
    entities: entities ?? this.entities,
    eventDate: eventDate ?? this.eventDate,
    finalResult: finalResult ?? this.finalResult,
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    joined: joined ?? this.joined,
    noCount: noCount ?? this.noCount,
    ownerId: ownerId ?? this.ownerId,
    paymentType: paymentType ?? this.paymentType,
    playerStatus: playerStatus ?? this.playerStatus,
    playersCount: playersCount ?? this.playersCount,
    question: question ?? this.question,
    refundedPlayersCount: refundedPlayersCount ?? this.refundedPlayersCount,
    resolvedBy: resolvedBy ?? this.resolvedBy,
    roomNumber: roomNumber ?? this.roomNumber,
    sourceOfTruth: sourceOfTruth ?? this.sourceOfTruth,
    status: status ?? this.status,
    subtopic: subtopic ?? this.subtopic,
    topic: topic ?? this.topic,
    tournamentId: tournamentId ?? this.tournamentId,
    updatedAt: updatedAt ?? this.updatedAt,
    username: username ?? this.username,
    winnersCount: winnersCount ?? this.winnersCount,
    yesCount: yesCount ?? this.yesCount,
    yourAnswer: yourAnswer ?? this.yourAnswer,
  );

  factory DuelModel.fromJson(Map<String, dynamic> json) {
    return DuelModel(
      approvedBy: json["approved_by"],
      bgUrl: json["bg_url"],
      cancellationReason: json["cancellation_reason"],
      commission: json["commission"],
      createdAt: DateTime.parse(json["created_at"]).toLocal(),
      deadline: DateTime.parse(json["deadline"]).toLocal(),
      duelInfo:
          json['duel_info'] != null
              ? DuelInfo.fromJson(json['duel_info'])
              : null,
      duelPrice: json["duel_price"],
      duelType: json["duel_type"],
      entities: List<int>.from(json["entities"]),
      eventDate: DateTime.parse(json["event_date"]).toLocal(),
      finalResult: json["final_result"],
      id: json["id"],
      imageUrl: json["image_url"],
      joined: json["joined"],
      noCount: json["no_count"] ?? 0,
      ownerId: json["owner_id"],
      paymentType: json["payment_type"],
      playerStatus: json["player_status"],
      playersCount: json["players_count"] ?? 0,
      question: json["question"],
      refundedPlayersCount: json["refunded_players_count"],
      resolvedBy: json["resolved_by"] ?? "",
      roomNumber: json["room_number"] ?? 0,
      sourceOfTruth: json["source_of_truth"],
      status: json["status"],
      subtopic: json["subtopic"],
      topic: json["topic"],
      tournamentId: json["tournament_id"],
      updatedAt: DateTime.parse(json["updated_at"]),
      username: json["username"],
      winnersCount: json["winners_count"],
      yesCount: json["yes_count"] ?? 0,
      yourAnswer: json["your_answer"],
    );
  }

  Map<String, dynamic> toJson() => {
    "approved_by": approvedBy,
    "bg_url": bgUrl,
    "cancellation_reason": cancellationReason,
    "commission": commission,
    "created_at": createdAt?.toIso8601String(),
    "deadline": deadline?.toIso8601String(),
    "duel_info": duelInfo?.toJson(),
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

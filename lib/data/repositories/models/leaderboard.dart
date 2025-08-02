import 'dart:convert';

Leaderboard leaderboardModelFromJson(String str) =>
    Leaderboard.fromJson(json.decode(str));

String leaderboardModelToJson(Leaderboard data) => json.encode(data.toJson());

class Leaderboard {
  final int earned;
  final int pnl;
  final int rank;
  final int spent;
  final int totalDuels;
  final String userId;
  final String username;
  final int victories;

  Leaderboard({
    required this.earned,
    required this.pnl,
    required this.rank,
    required this.spent,
    required this.totalDuels,
    required this.userId,
    required this.username,
    required this.victories,
  });

  Leaderboard copyWith({
    int? earned,
    int? pnl,
    int? rank,
    int? spent,
    int? totalDuels,
    String? userId,
    String? username,
    int? victories,
  }) => Leaderboard(
    earned: earned ?? this.earned,
    pnl: pnl ?? this.pnl,
    rank: rank ?? this.rank,
    spent: spent ?? this.spent,
    totalDuels: totalDuels ?? this.totalDuels,
    userId: userId ?? this.userId,
    username: username ?? this.username,
    victories: victories ?? this.victories,
  );

  factory Leaderboard.empty() {
    return Leaderboard(
      earned: 0,
      pnl: 0,
      rank: 0,
      spent: 0,
      totalDuels: 0,
      userId: "",
      username: "",
      victories: 0,
    );
  }

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
    earned: json["earned"],
    pnl: json["pnl"],
    rank: json["rank"],
    spent: json["spent"],
    totalDuels: json["total_duels"],
    userId: json["user_id"],
    username: json["username"],
    victories: json["victories"],
  );

  Map<String, dynamic> toJson() => {
    "earned": earned,
    "pnl": pnl,
    "rank": rank,
    "spent": spent,
    "total_duels": totalDuels,
    "user_id": userId,
    "username": username,
    "victories": victories,
  };

  @override
  String toString() {
    return 'Leaderboard(earned: $earned, pnl: $pnl, rank: $rank, spent: $spent, totalDuels: $totalDuels, userId: $userId, username: $username, victories: $victories)';
  }
}

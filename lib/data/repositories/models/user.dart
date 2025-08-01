import 'dart:convert';

User userModelFromJson(String str) => User.fromJson(json.decode(str));

String userModelToJson(User data) => json.encode(data.toJson());

class User {
  final int balance;
  final String bgUrl;
  final String bio;
  final DateTime createdAt;
  final int currentXp;
  final int dailyRewardStreak;
  final String discordUrl;
  final String email;
  final String id;
  final String imageUrl;
  final String instagramUrl;
  final bool isExternalWallet;
  final bool isPremium;
  final String lastCompletedStreak;
  final int level;
  final String publicAddress;
  final String referralToken;
  final int role;
  final bool solAutoswap;
  final String telegramId;
  final String telegramUrl;
  final bool twoFa;
  final String twoFaSecret;
  final String updatedAt;
  final bool usdcAutoswap;
  final String username;
  final String website;
  final String xUrl;
  final String youtubeUrl;

  User({
    required this.balance,
    required this.bgUrl,
    required this.bio,
    required this.createdAt,
    required this.currentXp,
    required this.dailyRewardStreak,
    required this.discordUrl,
    required this.email,
    required this.id,
    required this.imageUrl,
    required this.instagramUrl,
    required this.isExternalWallet,
    required this.isPremium,
    required this.lastCompletedStreak,
    required this.level,
    required this.publicAddress,
    required this.referralToken,
    required this.role,
    required this.solAutoswap,
    required this.telegramId,
    required this.telegramUrl,
    required this.twoFa,
    required this.twoFaSecret,
    required this.updatedAt,
    required this.usdcAutoswap,
    required this.username,
    required this.website,
    required this.xUrl,
    required this.youtubeUrl,
  });

  User copyWith({
    int? balance,
    String? bgUrl,
    String? bio,
    DateTime? createdAt,
    int? currentXp,
    int? dailyRewardStreak,
    String? discordUrl,
    String? email,
    String? id,
    String? imageUrl,
    String? instagramUrl,
    bool? isExternalWallet,
    bool? isPremium,
    String? lastCompletedStreak,
    int? level,
    String? publicAddress,
    String? referralToken,
    int? role,
    bool? solAutoswap,
    String? telegramId,
    String? telegramUrl,
    bool? twoFa,
    String? twoFaSecret,
    String? updatedAt,
    bool? usdcAutoswap,
    String? username,
    String? website,
    String? xUrl,
    String? youtubeUrl,
  }) => User(
    balance: balance ?? this.balance,
    bgUrl: bgUrl ?? this.bgUrl,
    bio: bio ?? this.bio,
    createdAt: createdAt ?? this.createdAt,
    currentXp: currentXp ?? this.currentXp,
    dailyRewardStreak: dailyRewardStreak ?? this.dailyRewardStreak,
    discordUrl: discordUrl ?? this.discordUrl,
    email: email ?? this.email,
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    instagramUrl: instagramUrl ?? this.instagramUrl,
    isExternalWallet: isExternalWallet ?? this.isExternalWallet,
    isPremium: isPremium ?? this.isPremium,
    lastCompletedStreak: lastCompletedStreak ?? this.lastCompletedStreak,
    level: level ?? this.level,
    publicAddress: publicAddress ?? this.publicAddress,
    referralToken: referralToken ?? this.referralToken,
    role: role ?? this.role,
    solAutoswap: solAutoswap ?? this.solAutoswap,
    telegramId: telegramId ?? this.telegramId,
    telegramUrl: telegramUrl ?? this.telegramUrl,
    twoFa: twoFa ?? this.twoFa,
    twoFaSecret: twoFaSecret ?? this.twoFaSecret,
    updatedAt: updatedAt ?? this.updatedAt,
    usdcAutoswap: usdcAutoswap ?? this.usdcAutoswap,
    username: username ?? this.username,
    website: website ?? this.website,
    xUrl: xUrl ?? this.xUrl,
    youtubeUrl: youtubeUrl ?? this.youtubeUrl,
  );

  factory User.empty() {
    return User(
      balance: 0,
      bgUrl: "",
      bio: "",
      createdAt: DateTime.now(),
      currentXp: 0,
      dailyRewardStreak: 0,
      discordUrl: "",
      email: "",
      id: "",
      imageUrl: "",
      instagramUrl: "",
      isExternalWallet: false,
      isPremium: false,
      lastCompletedStreak: "",
      level: 0,
      publicAddress: "",
      referralToken: "",
      role: -1,
      solAutoswap: false,
      telegramId: "",
      telegramUrl: "",
      twoFa: false,
      twoFaSecret: "",
      updatedAt: "",
      usdcAutoswap: false,
      username: "",
      website: "",
      xUrl: "",
      youtubeUrl: "",
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    balance: json["balance"],
    bgUrl: json["bg_url"],
    bio: json["bio"],
    createdAt: DateTime.parse(json["created_at"]),
    currentXp: json["current_xp"],
    dailyRewardStreak: json["daily_reward_streak"],
    discordUrl: json["discord_url"],
    email: json["email"],
    id: json["id"],
    imageUrl: json["image_url"],
    instagramUrl: json["instagram_url"],
    isExternalWallet: json["is_external_wallet"],
    isPremium: json["is_premium"],
    lastCompletedStreak: json["last_completed_streak"],
    level: json["level"],
    publicAddress: json["public_address"],
    referralToken: json["referral_token"],
    role: json["role"],
    solAutoswap: json["sol_autoswap"],
    telegramId: json["telegram_id"],
    telegramUrl: json["telegram_url"],
    twoFa: json["two_fa"],
    twoFaSecret: json["two_fa_secret"],
    updatedAt: json["updated_at"],
    usdcAutoswap: json["usdc_autoswap"],
    username: json["username"],
    website: json["website"],
    xUrl: json["x_url"],
    youtubeUrl: json["youtube_url"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "bg_url": bgUrl,
    "bio": bio,
    "created_at": createdAt.toIso8601String(),
    "current_xp": currentXp,
    "daily_reward_streak": dailyRewardStreak,
    "discord_url": discordUrl,
    "email": email,
    "id": id,
    "image_url": imageUrl,
    "instagram_url": instagramUrl,
    "is_external_wallet": isExternalWallet,
    "is_premium": isPremium,
    "last_completed_streak": lastCompletedStreak,
    "level": level,
    "public_address": publicAddress,
    "referral_token": referralToken,
    "role": role,
    "sol_autoswap": solAutoswap,
    "telegram_id": telegramId,
    "telegram_url": telegramUrl,
    "two_fa": twoFa,
    "two_fa_secret": twoFaSecret,
    "updated_at": updatedAt,
    "usdc_autoswap": usdcAutoswap,
    "username": username,
    "website": website,
    "x_url": xUrl,
    "youtube_url": youtubeUrl,
  };

  @override
  String toString() {
    return 'User(username: $username, email: $email, id: $id)';
  }
}

part of 'profile_cubit.dart';

abstract class ProfileState {
  final User? user;
  final Leaderboard? leaderboard;
  const ProfileState({required this.user, required this.leaderboard});

  ProfileState copyWith({final User? user, final Leaderboard? leaderboard});
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({super.user, super.leaderboard});

  @override
  ProfileInitial copyWith({final User? user, final Leaderboard? leaderboard}) =>
      ProfileInitial(
        user: user ?? this.user,
        leaderboard: leaderboard ?? this.leaderboard,
      );
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({required super.user, required super.leaderboard});

  @override
  ProfileLoading copyWith({final User? user, final Leaderboard? leaderboard}) =>
      ProfileLoading(
        user: user ?? this.user,
        leaderboard: leaderboard ?? this.leaderboard,
      );
}

class ProfileSuccessGet extends ProfileState {
  const ProfileSuccessGet({required super.user, required super.leaderboard});

  @override
  ProfileSuccessGet copyWith({
    final User? user,
    final Leaderboard? leaderboard,
  }) => ProfileSuccessGet(
    user: user ?? this.user,
    leaderboard: leaderboard ?? this.leaderboard,
  );
}

class ProfileErrorGet extends ProfileState {
  final String errorMessage;
  const ProfileErrorGet({
    required this.errorMessage,
    required super.user,
    required super.leaderboard,
  });

  @override
  ProfileErrorGet copyWith({
    final String? errorMessage,
    final User? user,
    final Leaderboard? leaderboard,
  }) => ProfileErrorGet(
    errorMessage: errorMessage ?? this.errorMessage,
    user: user ?? this.user,
    leaderboard: leaderboard ?? this.leaderboard,
  );
}

class ProfileLoadingChangeName extends ProfileState {
  const ProfileLoadingChangeName({
    required super.user,
    required super.leaderboard,
  });

  @override
  ProfileLoadingChangeName copyWith({
    final User? user,
    final Leaderboard? leaderboard,
  }) => ProfileLoadingChangeName(
    user: user ?? this.user,
    leaderboard: leaderboard ?? this.leaderboard,
  );
}

class ProfileSuccessChangeName extends ProfileState {
  const ProfileSuccessChangeName({
    required super.user,
    required super.leaderboard,
  });

  @override
  ProfileSuccessChangeName copyWith({
    final User? user,
    final Leaderboard? leaderboard,
  }) => ProfileSuccessChangeName(
    user: user ?? this.user,
    leaderboard: leaderboard ?? this.leaderboard,
  );
}

class ProfileErrorChangeName extends ProfileState {
  final String errorMessage;
  const ProfileErrorChangeName({
    required this.errorMessage,
    required super.user,
    required super.leaderboard,
  });

  @override
  ProfileErrorChangeName copyWith({
    final String? errorMessage,
    final User? user,
    final Leaderboard? leaderboard,
  }) => ProfileErrorChangeName(
    errorMessage: errorMessage ?? this.errorMessage,
    user: user ?? this.user,
    leaderboard: leaderboard ?? this.leaderboard,
  );
}

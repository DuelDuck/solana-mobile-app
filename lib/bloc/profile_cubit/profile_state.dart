part of 'profile_cubit.dart';

abstract class ProfileState {
  final User? user;
  const ProfileState({required this.user});

  ProfileState copyWith({final User? user});
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({super.user});

  @override
  ProfileInitial copyWith({final User? user}) =>
      ProfileInitial(user: user ?? this.user);
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({required super.user});

  @override
  ProfileLoading copyWith({final User? user}) =>
      ProfileLoading(user: user ?? this.user);
}

class ProfileSuccessGet extends ProfileState {
  const ProfileSuccessGet({required super.user});

  @override
  ProfileSuccessGet copyWith({final User? user}) =>
      ProfileSuccessGet(user: user ?? this.user);
}

class ProfileErrorGet extends ProfileState {
  final String errorMessage;
  const ProfileErrorGet({required this.errorMessage, required super.user});

  @override
  ProfileErrorGet copyWith({final String? errorMessage, final User? user}) =>
      ProfileErrorGet(
        errorMessage: errorMessage ?? this.errorMessage,
        user: user ?? this.user,
      );
}

class ProfileLoadingChangeName extends ProfileState {
  const ProfileLoadingChangeName({required super.user});

  @override
  ProfileLoadingChangeName copyWith({final User? user}) =>
      ProfileLoadingChangeName(user: user ?? this.user);
}

class ProfileSuccessChangeName extends ProfileState {
  const ProfileSuccessChangeName({required super.user});

  @override
  ProfileSuccessChangeName copyWith({final User? user}) =>
      ProfileSuccessChangeName(user: user ?? this.user);
}

class ProfileErrorChangeName extends ProfileState {
  final String errorMessage;
  const ProfileErrorChangeName({
    required this.errorMessage,
    required super.user,
  });

  @override
  ProfileErrorChangeName copyWith({
    final String? errorMessage,
    final User? user,
  }) => ProfileErrorChangeName(
    errorMessage: errorMessage ?? this.errorMessage,
    user: user ?? this.user,
  );
}

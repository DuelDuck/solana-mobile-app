part of 'home_cubit.dart';

abstract class HomeState {
  final List<DuelModel>? duelsList;
  const HomeState({required this.duelsList});

  HomeState copyWith({final List<DuelModel>? duelsList});
}

class HomeInitial extends HomeState {
  const HomeInitial({super.duelsList});

  @override
  HomeInitial copyWith({final List<DuelModel>? duelsList}) =>
      HomeInitial(duelsList: duelsList ?? this.duelsList);
}

class HomeLoading extends HomeState {
  const HomeLoading({required super.duelsList});

  @override
  HomeLoading copyWith({final List<DuelModel>? duelsList}) =>
      HomeLoading(duelsList: duelsList ?? this.duelsList);
}

class HomeSuccessGetDuels extends HomeState {
  const HomeSuccessGetDuels({required super.duelsList});

  @override
  HomeSuccessGetDuels copyWith({final List<DuelModel>? duelsList}) =>
      HomeSuccessGetDuels(duelsList: duelsList ?? this.duelsList);
}

class HomeErrorGetDuels extends HomeState {
  final String errorMessage;
  const HomeErrorGetDuels({
    required this.errorMessage,
    required super.duelsList,
  });

  @override
  HomeErrorGetDuels copyWith({
    final String? errorMessage,
    final List<DuelModel>? duelsList,
  }) => HomeErrorGetDuels(
    errorMessage: errorMessage ?? this.errorMessage,
    duelsList: duelsList ?? this.duelsList,
  );
}

class HomeSuccessJoinToDuel extends HomeState {
  const HomeSuccessJoinToDuel({required super.duelsList});

  @override
  HomeSuccessJoinToDuel copyWith({final List<DuelModel>? duelsList}) =>
      HomeSuccessJoinToDuel(duelsList: duelsList ?? this.duelsList);
}

class HomeErrorJoinToDuel extends HomeState {
  final String errorMessage;
  const HomeErrorJoinToDuel({
    required this.errorMessage,
    required super.duelsList,
  });

  @override
  HomeErrorJoinToDuel copyWith({
    final String? errorMessage,
    final List<DuelModel>? duelsList,
  }) => HomeErrorJoinToDuel(
    errorMessage: errorMessage ?? this.errorMessage,
    duelsList: duelsList ?? this.duelsList,
  );
}

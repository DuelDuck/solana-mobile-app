part of 'duels_cubit.dart';

abstract class DuelsState {
  final List<DuelModel> votedDuelsList;
  final List<DuelModel> createdDuelsList;
  final List<DuelModel> pendingDuelsList;
  final List<DuelModel> doneDuelsList;
  const DuelsState({
    required this.votedDuelsList,
    required this.createdDuelsList,
    required this.pendingDuelsList,
    required this.doneDuelsList,
  });

  DuelsState copyWith({
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  });
}

class DuelsInitial extends DuelsState {
  const DuelsInitial({
    super.votedDuelsList = const [],
    super.createdDuelsList = const [],
    super.pendingDuelsList = const [],
    super.doneDuelsList = const [],
  });

  @override
  DuelsInitial copyWith({
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  }) => DuelsInitial(
    votedDuelsList: votedDuelsList ?? this.votedDuelsList,
    createdDuelsList: createdDuelsList ?? this.createdDuelsList,
    pendingDuelsList: pendingDuelsList ?? this.pendingDuelsList,
    doneDuelsList: doneDuelsList ?? this.doneDuelsList,
  );
}

class DuelsLoading extends DuelsState {
  const DuelsLoading({
    required super.votedDuelsList,
    required super.createdDuelsList,
    required super.pendingDuelsList,
    required super.doneDuelsList,
  });

  @override
  DuelsLoading copyWith({
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  }) => DuelsLoading(
    votedDuelsList: votedDuelsList ?? this.votedDuelsList,
    createdDuelsList: createdDuelsList ?? this.createdDuelsList,
    pendingDuelsList: pendingDuelsList ?? this.pendingDuelsList,
    doneDuelsList: doneDuelsList ?? this.doneDuelsList,
  );
}

class DuelsSuccessGetList extends DuelsState {
  const DuelsSuccessGetList({
    required super.votedDuelsList,
    required super.createdDuelsList,
    required super.pendingDuelsList,
    required super.doneDuelsList,
  });

  @override
  DuelsSuccessGetList copyWith({
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  }) => DuelsSuccessGetList(
    votedDuelsList: votedDuelsList ?? this.votedDuelsList,
    createdDuelsList: createdDuelsList ?? this.createdDuelsList,
    pendingDuelsList: pendingDuelsList ?? this.pendingDuelsList,
    doneDuelsList: doneDuelsList ?? this.doneDuelsList,
  );
}

class DuelsErrorGetList extends DuelsState {
  final String errorMessage;
  const DuelsErrorGetList({
    required this.errorMessage,
    required super.votedDuelsList,
    required super.createdDuelsList,
    required super.pendingDuelsList,
    required super.doneDuelsList,
  });

  @override
  DuelsErrorGetList copyWith({
    final String? errorMessage,
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  }) => DuelsErrorGetList(
    errorMessage: errorMessage ?? this.errorMessage,
    votedDuelsList: votedDuelsList ?? this.votedDuelsList,
    createdDuelsList: createdDuelsList ?? this.createdDuelsList,
    pendingDuelsList: pendingDuelsList ?? this.pendingDuelsList,
    doneDuelsList: doneDuelsList ?? this.doneDuelsList,
  );
}

class DuelsSuccessResolve extends DuelsState {
  const DuelsSuccessResolve({
    required super.votedDuelsList,
    required super.createdDuelsList,
    required super.pendingDuelsList,
    required super.doneDuelsList,
  });

  @override
  DuelsSuccessResolve copyWith({
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  }) => DuelsSuccessResolve(
    votedDuelsList: votedDuelsList ?? this.votedDuelsList,
    createdDuelsList: createdDuelsList ?? this.createdDuelsList,
    pendingDuelsList: pendingDuelsList ?? this.pendingDuelsList,
    doneDuelsList: doneDuelsList ?? this.doneDuelsList,
  );
}

class DuelsErrorResolve extends DuelsState {
  final String errorMessage;
  const DuelsErrorResolve({
    required this.errorMessage,
    required super.votedDuelsList,
    required super.createdDuelsList,
    required super.pendingDuelsList,
    required super.doneDuelsList,
  });

  @override
  DuelsErrorResolve copyWith({
    final String? errorMessage,
    final List<DuelModel>? votedDuelsList,
    final List<DuelModel>? createdDuelsList,
    final List<DuelModel>? pendingDuelsList,
    final List<DuelModel>? doneDuelsList,
  }) => DuelsErrorResolve(
    errorMessage: errorMessage ?? this.errorMessage,
    votedDuelsList: votedDuelsList ?? this.votedDuelsList,
    createdDuelsList: createdDuelsList ?? this.createdDuelsList,
    pendingDuelsList: pendingDuelsList ?? this.pendingDuelsList,
    doneDuelsList: doneDuelsList ?? this.doneDuelsList,
  );
}

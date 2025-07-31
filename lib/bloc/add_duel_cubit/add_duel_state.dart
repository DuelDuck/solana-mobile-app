part of 'add_duel_cubit.dart';

abstract class AddDuelState {
  final CreateDuelModel? createDuelModel;
  final bool isPublishStep;
  const AddDuelState({
    required this.createDuelModel,
    required this.isPublishStep,
  });

  AddDuelState copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  });
}

class AddDuelInitial extends AddDuelState {
  const AddDuelInitial({super.createDuelModel, super.isPublishStep = false});

  @override
  AddDuelInitial copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelInitial(
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelCreateStep extends AddDuelState {
  const AddDuelCreateStep({
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelCreateStep copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelCreateStep(
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelPublishStep extends AddDuelState {
  const AddDuelPublishStep({
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelPublishStep copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelPublishStep(
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelLoading extends AddDuelState {
  const AddDuelLoading({
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelLoading copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelLoading(
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelSuccessSignTransaction extends AddDuelState {
  const AddDuelSuccessSignTransaction({
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelSuccessSignTransaction copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelSuccessSignTransaction(
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelErrorSignTransaction extends AddDuelState {
  final String errorMessage;
  const AddDuelErrorSignTransaction({
    required this.errorMessage,
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelErrorSignTransaction copyWith({
    final String? errorMessage,
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelErrorSignTransaction(
    errorMessage: errorMessage ?? this.errorMessage,
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelSuccessCreate extends AddDuelState {
  const AddDuelSuccessCreate({
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelSuccessCreate copyWith({
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelSuccessCreate(
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

class AddDuelErrorCreate extends AddDuelState {
  final String errorMessage;
  const AddDuelErrorCreate({
    required this.errorMessage,
    required super.createDuelModel,
    required super.isPublishStep,
  });

  @override
  AddDuelErrorCreate copyWith({
    final String? errorMessage,
    final CreateDuelModel? createDuelModel,
    final bool? isPublishStep,
  }) => AddDuelErrorCreate(
    errorMessage: errorMessage ?? this.errorMessage,
    createDuelModel: createDuelModel ?? this.createDuelModel,
    isPublishStep: isPublishStep ?? this.isPublishStep,
  );
}

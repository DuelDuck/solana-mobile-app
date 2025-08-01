import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/user.dart';
import 'package:duelduck_solana/data/repositories/profile_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileCubit() : super(const ProfileInitial());

  loadProfile() async {
    emit(ProfileLoading(user: state.user));

    try {
      ApiResponse<User?> response = await _profileRepository.getUser();

      if (response.errorMessage != null) {
        emit(
          ProfileErrorGet(
            errorMessage: response.errorMessage!,
            user: state.user,
          ),
        );
        return;
      }

      emit(ProfileSuccessGet(user: response.data ?? User.empty()));
    } catch (e) {
      emit(ProfileErrorGet(errorMessage: e.toString(), user: state.user));
    }
  }

  changeUserName(String newName) async {
    emit(ProfileLoadingChangeName(user: state.user));

    try {
      ApiResponse response = await _profileRepository.changeUserName(newName);

      if (response.errorMessage != null) {
        emit(
          ProfileErrorChangeName(
            errorMessage: response.errorMessage!,
            user: state.user,
          ),
        );
        return;
      }

      final updatedUser = state.user!.copyWith(username: newName);

      emit(ProfileSuccessChangeName(user: updatedUser));
    } catch (e) {
      emit(
        ProfileErrorChangeName(errorMessage: e.toString(), user: state.user),
      );
    }
  }
}

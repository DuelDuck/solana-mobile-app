import 'package:duelduck_solana/data/api/api_manager.dart';
import 'package:duelduck_solana/data/repositories/models/leaderboard.dart';
import 'package:duelduck_solana/data/repositories/models/user.dart';
import 'package:duelduck_solana/data/repositories/profile_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileCubit() : super(const ProfileInitial());

  loadProfile() async {
    emit(ProfileLoading(user: state.user, leaderboard: state.leaderboard));

    try {
      ApiResponse<User?> responseUser = await _profileRepository.getUser();

      if (responseUser.errorMessage != null) {
        emit(
          ProfileErrorGet(
            errorMessage: responseUser.errorMessage!,
            user: state.user,
            leaderboard: state.leaderboard,
          ),
        );
        return;
      }

      ApiResponse<Leaderboard?> responseLeaderboard =
          await _profileRepository.getLeaderboard();

      emit(
        ProfileSuccessGet(
          user: responseUser.data ?? User.empty(),
          leaderboard: responseLeaderboard.data,
        ),
      );
    } catch (e) {
      emit(
        ProfileErrorGet(
          errorMessage: e.toString(),
          user: state.user,
          leaderboard: state.leaderboard,
        ),
      );
    }
  }

  changeUserName(String newName) async {
    emit(
      ProfileLoadingChangeName(
        user: state.user,
        leaderboard: state.leaderboard,
      ),
    );

    try {
      ApiResponse response = await _profileRepository.changeUserName(newName);

      if (response.errorMessage != null) {
        emit(
          ProfileErrorChangeName(
            errorMessage: response.errorMessage!,
            user: state.user,
            leaderboard: state.leaderboard,
          ),
        );
        return;
      }

      final updatedUser = state.user!.copyWith(username: newName);

      emit(
        ProfileSuccessChangeName(
          user: updatedUser,
          leaderboard: state.leaderboard,
        ),
      );
    } catch (e) {
      emit(
        ProfileErrorChangeName(
          errorMessage: e.toString(),
          user: state.user,
          leaderboard: state.leaderboard,
        ),
      );
    }
  }
}

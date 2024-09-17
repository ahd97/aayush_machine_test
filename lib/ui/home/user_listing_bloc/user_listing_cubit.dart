import 'package:aayush_machine_test/core/di/api/repo/user_listing_repository.dart';
import 'package:aayush_machine_test/model/user_listing.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_listing_state.dart';

class UserListingCubit extends Cubit<UserListingState> {
  UserListingCubit() : super(UserListingInitial());

  Future<void> getUserListing(int pageNo) async {
    emit(UserListingLoading());

    try {
      var response = await userListRepo.getUserList(pageNo);
      if (response != null) {
        emit(UserListingSuccess(userListing: response));
      } else {
        emit(UserListingFailure('Not able to fetch data'));
      }
    } catch (e) {
      emit(UserListingFailure(e.toString()));
    }
  }
}

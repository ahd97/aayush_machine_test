part of 'user_listing_cubit.dart';

@immutable
sealed class UserListingState {}

final class UserListingInitial extends UserListingState {}


class UserListingLoading extends UserListingState {}

class UserListingSuccess extends UserListingState {
  final UserListing? userListing;
  UserListingSuccess({this.userListing});
}

class UserListingFailure extends UserListingState {
  final String error;

  UserListingFailure(this.error);
}
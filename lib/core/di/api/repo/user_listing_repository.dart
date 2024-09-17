import 'package:aayush_machine_test/core/di/api/api_end_points.dart';
import 'package:aayush_machine_test/core/di/api/http_client.dart';
import 'package:aayush_machine_test/model/user_listing.dart';

import '../../../locator.dart';

abstract class IUserListingRepository {
  Future<UserListing> getUserList(int pageNumber);
}

class UserListingRepository extends IUserListingRepository {
  @override
  Future<UserListing> getUserList(int pageNumber) async {
    final client = locator<HttpClient>();
    var request = {"page": pageNumber, "per_page": 10};
    final response = await client.get(APIEndPoints.userList, data: request);
    final finalData = UserListing.fromJson(response);
    return finalData;
  }
}

final userListRepo = locator<UserListingRepository>();

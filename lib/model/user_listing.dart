import 'package:aayush_machine_test/model/support_model.dart';
import 'package:aayush_machine_test/model/user_detail.dart';

class UserListing {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserDetail>? data;
  Support? support;

  UserListing({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory UserListing.fromJson(Map<String, dynamic> json) => UserListing(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data: json["data"] == null ? [] : List<UserDetail>.from(json["data"]!.map((x) => UserDetail.fromJson(x))),
    support: json["support"] == null ? null : Support.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "support": support?.toJson(),
  };
}
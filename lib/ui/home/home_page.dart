import 'package:aayush_machine_test/model/user_detail.dart';
import 'package:aayush_machine_test/ui/home/user_listing_bloc/user_listing_cubit.dart';
import 'package:aayush_machine_test/ui/home/widget/user_list_tile.dart';
import 'package:aayush_machine_test/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier showLoading = ValueNotifier<bool>(false);
  ValueNotifier<List<UserDetail>> users = ValueNotifier([]);
  int pageNumber = 1;
  bool isRefresh = false;
  ScrollController controller = ScrollController();
  late BuildContext lateContext;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        BlocProvider.of<UserListingCubit>(lateContext)
            .getUserListing(pageNumber);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<UserListingCubit>(
        create: (_) => UserListingCubit()..getUserListing(pageNumber),
        child: BlocConsumer<UserListingCubit, UserListingState>(
          listener: (context, state) {
            lateContext = context;
            if (state is UserListingSuccess) {
              if (isRefresh) {
                users.value.clear();
                (state.userListing?.data ?? []).forEach((element) {
                  users.value.add(element);
                });
                // setState(() {});
                isRefresh = false;
                if ((state.userListing?.totalPages ?? 0) > pageNumber) {
                  pageNumber += 1;
                }
              } else {
                (state.userListing?.data ?? []).forEach((element) {
                  users.value.add(element);
                });
                // setState(() {});
                if ((state.userListing?.totalPages ?? 0) > pageNumber) {
                  pageNumber += 1;
                }
              }
            }
          },
          builder: (context, state) {
            return Loading(
                status: (state is UserListingLoading &&
                    pageNumber == 1 &&
                    !isRefresh),
                child: Scaffold(
                    body: (state is UserListingSuccess)
                        ? ValueListenableBuilder(
                            valueListenable: users,
                            builder: (context, value, child) {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  isRefresh = true;
                                  pageNumber = 1;
                                  BlocProvider.of<UserListingCubit>(context)
                                      .getUserListing(pageNumber);
                                },
                                child: ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: users.value.length,
                                  controller: controller,
                                  itemBuilder: (context, index) {
                                    return UserListTile(
                                        name:
                                            "${users.value[index].firstName ?? ''} ${users.value[index].lastName ?? ''}",
                                        email: users.value[index].email ?? '',
                                        avatarUrl:
                                            users.value[index].avatar ?? '');
                                  },
                                ),
                              );
                            })
                        : (state is UserListingFailure && pageNumber == 1)
                            ? Text("User List not found")
                            : SizedBox.shrink()));
          },
        ),
      ),
    );
  }
}

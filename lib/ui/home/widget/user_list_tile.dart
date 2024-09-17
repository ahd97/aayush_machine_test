import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String email;
  final String avatarUrl;

  UserListTile({
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              avatarUrl), // Or use AssetImage if the image is local
          radius: 24.0, // Adjust radius as needed
        ),
        title: Text(name),
        subtitle: Text(email),
      ),
    );
  }
}

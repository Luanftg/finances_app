import 'package:finances_app/src/shared/design/design.dart';
import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget(
      {super.key,
      required this.userName,
      required this.userEmail,
      this.photoUrl});
  final String userName;
  final String userEmail;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Scaffold.of(context).isDrawerOpen
          ? Scaffold.of(context).closeDrawer
          : Scaffold.of(context).openDrawer,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(4),
            child: CircleAvatar(
              child: photoUrl != null
                  ? Image.network(photoUrl!)
                  : Icon(Icons.person_2_outlined),
              maxRadius: 22,
            ),
          ),
          Flexible(
            child: ListTile(
              title: Text(userName),
              subtitle: Text(
                userEmail,
                style: TextStyle(color: AppCustomColors.i.white, fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onProfileTap,
    this.onNotificationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.notifications_none, color: Colors.black87),
        ),

        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
            radius: 16,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

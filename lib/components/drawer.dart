import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
          colors: [Color.fromARGB(255, 128, 48, 240), Color.fromARGB(255, 9, 0, 249)],
          stops: [0.6,0.9],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const DrawerHeader(
                    child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 100,
                )),
                MyListTile(
                    icon: (Icons.home),
                    text: 'H O M E',
                    onTap: () => Navigator.pop(context)),
                MyListTile(
                    icon: Icons.person,
                    text: 'P R O F I L E',
                    onTap: onProfileTap),
                    
                MyListTile(
                    icon: Icons.paypal_outlined,
                    text: 'P U S S Y',
                    onTap: null),    
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: MyListTile(
                  icon: Icons.logout, text: 'L O G O U T', onTap: onSignOut),
            ),
          ],
        ),
      ),
    );
  }
}

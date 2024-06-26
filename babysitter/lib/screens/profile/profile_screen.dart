import 'package:babysitter/screens/auth/signin_screen.dart';
import 'package:babysitter/screens/profile/rendezVousBabySitter.dart';
import 'package:babysitter/screens/profile/update_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  final String type;
  static String routeName = "/profile";

  const ProfileScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? user = GetStorage().read(type);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(),
            const SizedBox(height: 20),
            user == null
                ? SizedBox()
                : Text(
                    "${user['nom'] ?? ''}", // Remplacez par le nom et le prénom réel
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            user == null
                ? SizedBox()
                : Text(
                    "${user['email'] ?? ''}", // Remplacez par l'adresse e-mail réelle
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: CupertinoIcons.profile_circled,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (e) => UptadeProfileScreen(),
                  ),
                );
              },
            ),
            ProfileMenu(
              text: "Rendez Vous",
              icon: CupertinoIcons.bell,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (e) => RendezVousBabySitter(
                      type: 'babysitter',
                    ),
                  ),
                );
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: CupertinoIcons.bell,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: CupertinoIcons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: CupertinoIcons.info,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: CupertinoIcons.power,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(
                      type: '',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

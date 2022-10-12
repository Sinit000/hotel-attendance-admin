import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/language/sreen/language.dart';

import 'package:hotle_attendnce_admin/src/feature/setting/screen/setting_tile.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: standardAppBar(context, "Setting page"),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            // settingitem(
            //     name: "Group Department",
            //     icon: Icons.people,
            //     onPressed: () {
            //       Navigator.pushNamed(context, group);
            //     }),
            // SizedBox(
            //   height: 10,
            // ),
            settingitem(
                name: "Language",
                icon: Icons.language_outlined,
                onPressed: () {
                  languageModal(context);
                }),
            SizedBox(
              height: 10,
            ),
            settingitem(
                name: "Contact us",
                icon: Icons.phone_callback_outlined,
                onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            settingitem(
                name: "Help",
                icon: Icons.help_center_outlined,
                onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            // settingitem(name: "Theme", icon: Icons.dark_mode, onPressed: () {}),
            // SizedBox(
            //   height: 10,
            // ),
          ],
        ));
  }
}

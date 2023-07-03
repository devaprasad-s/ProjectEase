import 'package:app_uno/screens/admin_profile.dart';
import 'package:app_uno/screens/admin_projects.dart';
import 'package:app_uno/screens/admin_deadlines.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        SizedBox(
          height: 26,
        ),
        ListTile(
          leading: Icon(Icons.person_outline),
          title: Text('Profile'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminProfilePage(
                          username: '',
                        )));
          },
        ),
        ListTile(
          leading: Icon(Icons.dashboard_customize_outlined),
          title: Text('Project Requests'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjectsPage()));
          },
        ),
        /*
        ListTile(
          leading: Icon(Icons.group_outlined),
          title: Text('Guides'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          username: '',
                        )));
          },
        ),*/
        ListTile(
          leading: Icon(Icons.timer_outlined),
          title: Text('Deadlines'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeadlinesPage()));
          },
        ),
      ],
    ));
  }
}

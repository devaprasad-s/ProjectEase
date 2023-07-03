import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_uno/screens/admin_projectview.dart';

import '../widgets/navbar.dart';

class ProjectsPage extends StatefulWidget {
  //final String projectName;

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  //Values values = RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(title: 'All Projects'),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SafeArea(
              child: Positioned(
                  top: 10,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminProViewPage()));
                            },
                            child: SizedBox(
                              width: 370,
                              height: 94,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7FAF9),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Text(
                                          'Mini Project',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF0007B7)),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Project Name',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Spacer(),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(children: [
                                                Text("View"),
                                                Icon(Icons
                                                    .arrow_forward_ios_outlined)
                                              ]))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Group (No)',
                                            style: TextStyle(
                                                color: Color(0xFF3F4949)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  )));
        },
      ),
    );
  }
}

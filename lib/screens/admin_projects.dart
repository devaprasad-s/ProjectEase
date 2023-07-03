import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_uno/screens/admin_projectview.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:io';

import '../db/sqlhelper.dart';
import '../widgets/navbar.dart';

class ProjectsPage extends StatefulWidget {
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Map<String, dynamic>> projects = [];

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> projectList = await db.query('projects');
    setState(() {
      projects = projectList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(title: 'All Projects'),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          final groupNo = project['groupno'].toString();
          final projectName = project['projname'].toString();
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
                              builder: (context) => AdminProViewPage(
                                  groupNo: groupNo, projname: projectName),
                            ),
                          );
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
                                  Row(
                                    children: [
                                      Text(
                                        'Mini Project',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF0007B7),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        projectName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            Text("View"),
                                            Icon(Icons
                                                .arrow_forward_ios_outlined),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Group ($groupNo)',
                                        style: TextStyle(
                                          color: Color(0xFF3F4949),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

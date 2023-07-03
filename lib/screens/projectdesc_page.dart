import 'dart:ffi';

import 'package:app_uno/screens/view_submissions.dart';
import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../db/sqlhelper.dart';

class ProjectDetailsPage extends StatefulWidget {
  final String projectName;
  final String username;

  ProjectDetailsPage({required this.username, required this.projectName});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  //Values values = RangeValues(0, 100);
  TextEditingController _groupNoController = TextEditingController();
  TextEditingController _member1Controller = TextEditingController();
  TextEditingController _member2Controller = TextEditingController();
  TextEditingController _member3Controller = TextEditingController();
  TextEditingController _member4Controller = TextEditingController();
  TextEditingController _guideController = TextEditingController();
  double value = 0;
  final String submissionType = "Design Phase";

  @override
  void initState() {
    super.initState();
    // Assign the username from the widget parameter to the local variable
    fetchUserDetails(widget.username);
  }

  Future<void> fetchUserDetails(String username) async {
    final userDetails = await SQLHelper.getUserDetails(username);

    if (userDetails != null) {
      final int groupno = userDetails['groupno'];
      final projectDetails = await SQLHelper.getProjectDetails(groupno);
      final groupDetails = await SQLHelper.getGroupDetails(groupno);
      if (groupDetails != null && projectDetails != null) {
        final String member1 = groupDetails['member1'];
        final String member2 = groupDetails['member2'];
        final String member3 = groupDetails['member3'];
        final String member4 = groupDetails['member4'];
        final String? guide = groupDetails['guide'];
        _groupNoController.text = groupno.toString();
        _member1Controller.text = member1;
        _member2Controller.text = member2;
        _member3Controller.text = member3;
        _member4Controller.text = member4;
        if (guide == null) {
          _guideController.text = 'Yet to be assigned.';
        }
        print('groupno: $groupno');
        print('member1: $member1');
        print('member2: $member2');
        print('member3: $member3');
        print('member4: $member4');
        print('guide: $guide');
      } else {
        print('Group/Project not found');
      }

      // Use the user details as neede
    } else {
      print('User not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    //RangeLabels labels =
    //RangeLabels(values.start.toString(), values.end.toString());
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: widget.projectName),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 100,
          //width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 20,
                  right: 20,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(children: [
                        Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                      //),
                      SizedBox(height: 16),
                      Row(children: [
                        SizedBox(width: 16),
                        Text(
                          'Group No',
                          style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 19),
                        Expanded(
                            child: Column(children: [
                          SizedBox(
                            width: 250,
                            height: 30,
                            child: TextFormField(
                              readOnly: true,
                              controller: _groupNoController,
                              decoration: InputDecoration(
                                //hintText: '',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8), // Adjust the vertical padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //onChanged: updateGroupNo,
                            ),
                          ),
                        ])),
                      ]),
                      SizedBox(height: 8),
                      Row(children: [
                        SizedBox(width: 16),
                        Text(
                          'Members',
                          style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 19),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 8),
                              SizedBox(
                                width: 250,
                                height: 30,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _member1Controller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outlined,
                                        color: Colors.black),
                                    filled: true,
                                    fillColor: Color(0xFFCADCFF),
                                    //hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical:
                                            8), // Adjust the vertical padding
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  //onChanged: updateGroupNo,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 250,
                                height: 30,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _member2Controller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outlined,
                                        color: Colors.black),
                                    filled: true,
                                    fillColor: Color(0xFFCADCFF),
                                    //hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical:
                                            8), // Adjust the vertical padding
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  //onChanged: updateGroupNo,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 250,
                                height: 30,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _member3Controller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outlined,
                                        color: Colors.black),
                                    filled: true,
                                    fillColor: Color(0xFFCADCFF),
                                    //hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical:
                                            8), // Adjust the vertical padding
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  //onChanged: updateGroupNo,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 250,
                                height: 30,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _member4Controller,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outlined,
                                        color: Colors.black),
                                    filled: true,
                                    fillColor: Color(0xFFCADCFF),
                                    //hintText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical:
                                            8), // Adjust the vertical padding
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  //onChanged: updateGroupNo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),
                      Row(children: [
                        SizedBox(width: 16),
                        Text(
                          'Guide        ',
                          style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 17),
                        Expanded(
                            child: Column(children: [
                          SizedBox(
                            width: 250,
                            height: 30,
                            child: TextFormField(
                              readOnly: true,
                              controller: _guideController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outlined,
                                    color: Colors.black),
                                hintText: 'Not Assigned',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8), // Adjust the vertical padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //onChanged: updateGroupNo,
                            ),
                          ),
                        ])),
                      ]),
                      SizedBox(height: 16),
                      /*Row(children: [
                        SizedBox(width: 16),
                        Text(
                          'Batch        ',
                          style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 17),
                        Expanded(
                            child: Column(children: [
                          SizedBox(
                            width: 250,
                            height: 30,
                            child: TextFormField(
                              //readOnly: true,
                              decoration: InputDecoration(
                                //hintText: 'Not Assigned',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8), // Adjust the vertical padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //onChanged: updateGroupNo,
                            ),
                          ),
                        ])),
                      ]),
                      SizedBox(height: 16),*/
                      Row(children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                      SizedBox(height: 26),
                      SliderTheme(
                          data: SliderThemeData(
                              thumbColor: Colors.black,
                              valueIndicatorColor: Color(0xFF0045CB),
                              valueIndicatorShape:
                                  DropSliderValueIndicatorShape(),
                              showValueIndicator: ShowValueIndicator.always),
                          child: Slider(
                            thumbColor: Colors.black,
                            value: value,
                            max: 100.0,
                            label: value.round().toString(),
                            divisions: 10,
                            activeColor: Color(0xFF0A71BB),
                            inactiveColor: Color(0xFFA496F5),
                            onChanged: (newValue) {
                              value = newValue;
                              setState(() {});
                            },
                          )),
                      SizedBox(height: 16),
                      Row(children: [
                        Text(
                          'Deadlines',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 350,
                        //height: 400,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color(0xFFFEF9F7),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                    child: Column(children: [
                                  Icon(Icons.upload_file_rounded),
                                  SizedBox(height: 10),
                                  Text('12 June 2023'),
                                  SizedBox(height: 10),
                                  Text(
                                      "Design Phase Presentation is scheduled on 04-06-2023 ",
                                      textAlign: TextAlign.center)
                                ])),
                                SizedBox(height: 8),
                                InkWell(
                                  onTap: () {
                                    setState(() {});
                                    //Navigator.pop(context, projectName);
                                    //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 108,
                                      height: 32,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.84),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFB0D3F4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.21),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.w400,
                                            height: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(children: [
                        Text(
                          'Remarks',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewSubmissionPage(
                                  projectName: widget.projectName,
                                  submissionType: submissionType),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 400,
                          height: 70,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFFD1DEFF),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(children: [
                                  Text(
                                    submissionType,
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
                                        Icon(Icons.arrow_forward_ios_outlined)
                                      ]))
                                ])),
                          ),
                        ),
                      ),
                      /*SizedBox(
                    //width: 350,
                    //height: 400,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Color(0xFFFEF9F7)),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Center(
                                child: Column(children: [
                              Icon(Icons.upload_file_rounded),
                              SizedBox(height: 10),
                              Text('12 June 2023'),
                              SizedBox(height: 10),
                              Text(
                                  "Desigse Presentation is scheduled on 04-06-2023 ",
                                  textAlign: TextAlign.center)
                            ])),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                setState(() {});
                                //Navigator.pop(context, projectName);
                                //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

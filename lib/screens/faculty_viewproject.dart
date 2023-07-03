import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class FacultyProViewPage extends StatefulWidget {
  //final String projectName;

  //ProjectDetailsPage({required this.projectName});

  @override
  State<FacultyProViewPage> createState() => _FacultyProViewPageState();
}

class _FacultyProViewPageState extends State<FacultyProViewPage> {
  //Values values = RangeValues(0, 100);
  //double value = 0;
  //final String submissionType = "Design Phase";

  @override
  Widget build(BuildContext context) {
    //RangeLabels labels =
    //RangeLabels(values.start.toString(), values.end.toString());
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'projectName'),
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
                            fontSize: 23,
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

                      /*SliderTheme(
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
                          )),*/
                      SizedBox(height: 16),
                      Row(children: [
                        Text(
                          'Uploaded Documents',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewSubmissionPage(
                                      projectName: widget.projectName,
                                      submissionType: submissionType),
                                ),
                              );*/
                          },
                          child: SizedBox(
                            width: 370,
                            height: 70,
                            //color: Color(0xFFD1DEFF),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F6),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(children: [
                                    Text(
                                      'Design.pdf',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Text("Download"),
                                    SizedBox(width: 7),
                                    Icon(Icons.arrow_forward_ios_outlined)
                                  ])),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),
                      Row(children: [
                        Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                      SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            'Write a comment',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 26,
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              decoration: InputDecoration(
                                hintText:
                                    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ',
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 8, 16, 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //onChanged: updatePhoneNumber,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          //Navigator.pop(context, projectName);
                          //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 108,
                            height: 32,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.84),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFB0D3F4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.21),
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

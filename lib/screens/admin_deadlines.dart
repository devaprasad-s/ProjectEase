import 'package:app_uno/screens/admin_createdeadline.dart';
import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:app_uno/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DeadlinesPage extends StatefulWidget {
  //final String projectName;

  @override
  State<DeadlinesPage> createState() => _DeadlinesPageState();
}

class _DeadlinesPageState extends State<DeadlinesPage> {
  //Values values = RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      //extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: 'Deadlines'),
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
                    children: [
                      Row(
                        children: [
                          Text(
                            'Current Deadlines',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                                  SizedBox(height: 10),
                                  Text(
                                    'Design Phase ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                ])),
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
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('Remove');
                                        setState(() {});
                                        //Navigator.pop(context, projectName);
                                        //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                                      },
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
                                            'Remove',
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
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        print('Edit');
                                        setState(() {});
                                        //Navigator.pop(context, projectName);
                                        //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                                      },
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
                                            'Edit',
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
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                                  SizedBox(height: 10),
                                  Text(
                                    'Introduction Phase ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                ])),
                                Center(
                                    child: Column(children: [
                                  Icon(Icons.upload_file_rounded),
                                  SizedBox(height: 10),
                                  Text('12 June 2023'),
                                  SizedBox(height: 10),
                                  Text(
                                      "Introduction Phase Presentation is scheduled on 02-06-2023 ",
                                      textAlign: TextAlign.center)
                                ])),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print('Remove');
                                        setState(() {});
                                        //Navigator.pop(context, projectName);
                                        //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                                      },
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
                                            'Remove',
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
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        print('Edit');
                                        setState(() {});
                                        //Navigator.pop(context, projectName);
                                        //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                                      },
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
                                            'Edit',
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateDeadlinesPage()));
                            setState(() {});
                            //Navigator.pop(context, projectName);
                            //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                          },
                          child: Container(
                            width: 140,
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFB0D3F4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.21),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Spacer(),
                                Text(
                                  'Create Deadline',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            'Previous Deadlines',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 400,
                          height: 80,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFFD1DEFF),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(children: [
                                Row(children: [
                                  Text(
                                    '03 February 22',
                                    style: TextStyle(
                                        fontSize: 13, color: Color(0xFF6D0000)),
                                  ),
                                ]),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(children: [
                                  Text(
                                    'Zeroth Phase',
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
                                ])
                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 400,
                          height: 80,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFFD1DEFF),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(children: [
                                Row(children: [
                                  Text(
                                    '03 February 22',
                                    style: TextStyle(
                                        fontSize: 13, color: Color(0xFF6D0000)),
                                  ),
                                ]),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(children: [
                                  Text(
                                    'Zeroth Phase',
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
                                ])
                              ]),
                            ),
                          ),
                        ),
                      ),
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

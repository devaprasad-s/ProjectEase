import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ViewSubmissionPage extends StatefulWidget {
  final String projectName;
  final String submissionType;

  ViewSubmissionPage({required this.projectName, required this.submissionType});

  @override
  State<ViewSubmissionPage> createState() => _ViewSubmissionPageState();
}

class _ViewSubmissionPageState extends State<ViewSubmissionPage> {
  //final String projectName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.projectName),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                  child: Stack(children: [
                Positioned(
                    top: 10,
                    left: 20,
                    right: 20,
                    child: Column(children: [
                      Row(children: [
                        Text(
                          widget.submissionType,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          height: 100,
                          width: 400,
                          child: Text(
                            "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {});
                          //Navigator.pop(context, projectName);
                          //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                        },
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 118,
                            height: 40,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.84),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFB0D3F4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.21),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'View Template',
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
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Submission date"),
                          SizedBox(width: 36),
                          SizedBox(
                              width: 210,
                              height: 30,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      //color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0))),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("22-04-2022",
                                          textAlign: TextAlign.center))))
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Upload document"),
                          SizedBox(width: 26),
                          InkWell(
                            onTap: () {
                              setState(() {});
                              //Navigator.pop(context, projectName);
                              //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 210,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.84),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFB0D3F4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Upload PDF',
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
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Uploaded documents",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 26),
                        ],
                      ),
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
                            width: 350,
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
                      Row(
                        children: [
                          Text(
                            "Comments",
                            style: TextStyle(fontSize: 20),
                          ),
                          //SizedBox(width: 26),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(color: Color(0xFFFEF9F7)),
                            child: SizedBox(
                              width: 350,
                              //height: 10,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline),
                                        SizedBox(width: 16),
                                        Text(
                                          'Divya VL',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Spacer(),
                                        Text('12-05-2002')
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(color: Color(0xFFFEF9F7)),
                            child: SizedBox(
                              width: 350,
                              //height: 10,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline),
                                        SizedBox(width: 16),
                                        Text(
                                          'Sujithra M S',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Spacer(),
                                        Text('12-05-2002')
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. ',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]))
              ])))),
    );
  }
}

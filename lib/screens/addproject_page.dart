import 'package:flutter/material.dart';

class AddProjectPage extends StatefulWidget {
  final String semester;

  AddProjectPage({required this.semester});

  @override
  AddProjectPageState createState() => AddProjectPageState();
}

class AddProjectPageState extends State<AddProjectPage> {
  String? groupNo;

  void updateGroupNo(String value) {
    setState(() {
      groupNo = value;
    });
  }

  String getBatchValue(String sn) {
    int semester =
        int.parse(sn.substring(1)); // Extract the semester number correctly
    int currentYear = DateTime.now().year;
    late int startYear;
    late int endYear;
    int ceilSemester = (semester / 2).floor();

    switch (ceilSemester) {
      case 0:
        startYear = currentYear - 0;
        endYear = currentYear + 4;
        break;
      case 1:
        startYear = currentYear - 1;
        endYear = currentYear + 3;
        break;
      case 2:
        startYear = currentYear - 2;
        endYear = currentYear + 2;
        break;
      case 3:
        startYear = currentYear - 3;
        endYear = currentYear + 1;
        break;
      case 4:
        startYear = currentYear - 4;
        endYear = currentYear + 0;
        break;
    }

    return '$startYear-$endYear';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 12,
                right: 12,
                child: SafeArea(
                  child: SizedBox(
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD1DEFF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Add Project',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Create Project ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 190,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Group No',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter group number',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onChanged: updateGroupNo,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(children: [
                      Text('Semester', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.semester,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'Passed Semester',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 16),
                    Positioned(
                      top: 290,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Members',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  color: Color(0xFFCADCFF),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person_2_outlined),
                                      SizedBox(width: 4),
                                      Text(
                                        'Your Name',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Positioned(
                      top: 290,
                      left: 80,
                      right: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Add member functionality
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFB0D3F4),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(width: 4),
                                      Text(
                                        'Add Member',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(children: [
                      Text('Batch', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: getBatchValue(widget.semester),
                          //readOnly: true,
                          decoration: InputDecoration(
                            //filled: true,
                            //fillColor: Colors.grey[200],
                            hintText: 'Passed Semester',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),

              // Add your project form widgets and logic here
            ],
          ),
        ),
      ),
    );
  }
}

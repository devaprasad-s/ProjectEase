import 'package:app_uno/screens/admin_projects.dart';
import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:app_uno/widgets/navbar.dart';
import 'package:flutter/material.dart';

class CreateDeadlinesPage extends StatefulWidget {
  //final String projectName;

  @override
  State<CreateDeadlinesPage> createState() => _CreateDeadlinesPageState();
}

class _CreateDeadlinesPageState extends State<CreateDeadlinesPage> {
  //Values values = RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(title: 'Create Deadline'),
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
                            'Title    ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 66),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter the title',
                                contentPadding: EdgeInsets.fromLTRB(
                                    16, 0, 16, 0 //vertical: 8
                                    ), // Adjust the vertical padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //onChanged: updateEmail,
                              controller: TextEditingController(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Date             ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 26,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'DD Month YY',
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
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
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            'Read Me',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Uploaded',
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 0, 16, 0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //onChanged: updatePhoneNumber,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          print('Edit');
                          setState(() {});
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
                                'Upload',
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProjectsPage()));
                          setState(() {});
                          //Navigator.pop(context, projectName);
                          //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                        },
                        child: Align(
                          alignment: Alignment.center,
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

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:app_uno/widgets/custom_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../db/sqlhelper.dart';

class AddProjectPage extends StatefulWidget {
  final String semester;
  final String username;

  AddProjectPage({required this.username, required this.semester});

  @override
  AddProjectPageState createState() => AddProjectPageState();
}

class AddProjectPageState extends State<AddProjectPage> {
  final TextEditingController _projectName = TextEditingController();
  final TextEditingController _groupNo = TextEditingController();
  final TextEditingController _member1 = TextEditingController();
  final TextEditingController _member2 = TextEditingController();
  final TextEditingController _member3 = TextEditingController();
  final TextEditingController _member4 = TextEditingController();
  String? groupNo;
  String? projectName;
  String? filePath;
  List<String> usernames = [];
  final TextEditingController abstractDocumentPath = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsernames();
    fetchUserDetails(widget.username);
  }

  Future<void> fetchUserDetails(String username) async {
    final userDetails = await SQLHelper.getUserDetails(username);

    if (userDetails != null) {
      final int groupno = userDetails['groupno'];
      _groupNo.text = groupno.toString();
      final projectDetails = await SQLHelper.getProjectDetails(groupno);
      if (projectDetails != null) {
        final String projname = projectDetails['projname'];
        _projectName.text = projname;
        print('PROJJJJJNAME $projname');
        final groupDetails = await SQLHelper.getGroupDetails(groupno);
        if (groupDetails != null) {
          final String? member2 = groupDetails['member2'];
          final String? member3 = groupDetails['member3'];
          final String? member4 = groupDetails['member4'];
          _member2.text = member2!;
          _member3.text = member3!;
          _member4.text = member4!;
          fetchDocDetails(groupno.toString());
        }
      }
    } else {
      print('User not found');
    }
  }

  Future<void> fetchUsernames() async {
    final List<String> fetchedUsernames = await SQLHelper.getUsernames();
    setState(() {
      usernames = fetchedUsernames;
    });
  }

  /*Future<void> fetchDocDetails(String groupno) async {
    final documentDetails =
        await SQLHelper.getDocumentDetails(int.parse(groupNo!));
    if (documentDetails != null) {
      final String abstractDoc = documentDetails['abstract'];

      abstractDocumentPath.text = abstractDoc;
      OpenFile.open(
          '/document/primary:Download/Whatsapp Image 2023-06-01 at 19.28.45.jpg');
      // Use the user details as needed
      print('PATH: $abstractDoc');
    } else {
      print('User not found');
    }
  }*/

  Future<void> fetchDocDetails(String groupNo) async {
    final documentDetails =
        await SQLHelper.getDocumentDetails(int.parse(groupNo));
    if (documentDetails != null) {
      final String abstractDoc = documentDetails['abstract'];

      abstractDocumentPath.text = abstractDoc;
      OpenFile.open(abstractDoc);
      // Use the user details as needed
      print('PATH: $abstractDoc');

      // Store the abstract document path in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('abstractDocumentPath', abstractDoc);
    } else {
      print('User not found');
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /*Future<void> openFilePicker() async {
    
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? cacheFilePath = result.files.single.path;

      if (cacheFilePath != null) {
        final appDirectory =
            await getApplicationDocumentsDirectory(); // Replace with your desired group number

        // Create the group directory if it doesn't exist
        final groupDirectory =
            Directory('${appDirectory.path}/group${_groupNo.text}');
        if (!await groupDirectory.exists()) {
          await groupDirectory.create(recursive: true);
        }

        final actualFilePath = '${groupDirectory.path}/abstract.png';
        final cachedFile = File(cacheFilePath);
        await cachedFile.copy(actualFilePath);

        setState(() {
          filePath = actualFilePath;
        });

        // Use the filePath variable for further processing
        print('Selected file path: $filePath');
        final sqlHelper = SQLHelper();
        await sqlHelper.insertFilePath(int.parse(_groupNo.text), filePath);
      } else {
        // Handle case when cacheFilePath is null
        print('Cache file path is null');
      }
    } else {
      // Handle case when file picking is canceled
      print('File picking canceled');
    }
  }*/

  @override
  void dispose() {
    super.dispose();
    _projectName.dispose();
    _groupNo.dispose();
    _member1.dispose();
    _member2.dispose();
    _member3.dispose();
    _member4.dispose();
  }

  void openFilePicker() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.single;
      final filePath = file.path;
      print('THIS IS YOUR FILE PATH: $filePath');
      final sqlHelper = SQLHelper();
      await sqlHelper.insertFilePath(int.parse(_groupNo.text), filePath);

      // Store the uploaded file path in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('abstractDocumentPath', filePath!);
    }
  }

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
      appBar: CustomAppBar(title: 'Add Project'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Create Project',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text('Group No', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 40),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _groupNo,
                            decoration: InputDecoration(
                              hintText: 'Enter group number',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8), // Adjust the vertical padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onChanged: updateGroupNo,
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Row(children: [
                        Text('Semester', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 40),
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.semester,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Passed Semester',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8), // Adjust the vertical padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Row(children: [
                        Text('Batch', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 64),
                        Expanded(
                          child: TextFormField(
                            initialValue: getBatchValue(widget.semester),
                            decoration: InputDecoration(
                              hintText: 'Passed Semester',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8), // Adjust the vertical padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Row(children: [
                        Text('Project Name', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _projectName,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8), // Adjust the vertical padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Column(
                        children: [
                          Row(children: [
                            Text('Abstract', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 40),
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () {
                                fetchDocDetails(_groupNo
                                    .text); // Perform the repeated insertion logic here
                              },
                              child: Text(
                                'View documents',
                                style: TextStyle(fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.grey),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                              ),
                            )),
                          ]),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                openFilePicker(); // Add your logic here for the button's onTap event
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
                                    borderRadius: BorderRadius.circular(5.21),
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
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Members',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(height: 8),
                                    SizedBox(
                                      width: 250,
                                      height: 30,
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: widget.username,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.person_outlined,
                                              color: Colors.black),
                                          filled: true,
                                          fillColor: Color(0xFFCADCFF),
                                          //hintText: '',
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical:
                                                  8), // Adjust the vertical padding
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        //onChanged: updateGroupNo,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    SizedBox(
                                      width: 250,
                                      height: 30,
                                      child: DropdownButtonFormField<String>(
                                          value: _member2.text.isNotEmpty
                                              ? _member2.text
                                              : null,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.person_outlined,
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: Color(0xFFCADCFF),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          items:
                                              usernames.map((String username) {
                                            return DropdownMenuItem<String>(
                                              value: username,
                                              child: Text(username),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _member2.text = newValue!;

                                              // Handle the selected value here
                                            });
                                          }),
                                    ),
                                    SizedBox(height: 8),
                                    SizedBox(
                                      width: 250,
                                      height: 30,
                                      child: DropdownButtonFormField<String>(
                                          value: _member3.text.isNotEmpty
                                              ? _member3.text
                                              : null,
                                          //value: _member3.text,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.person_outlined,
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: Color(0xFFCADCFF),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          items:
                                              usernames.map((String username) {
                                            return DropdownMenuItem<String>(
                                              value: username,
                                              child: Text(username),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _member3.text = newValue!;

                                              // Handle the selected value here
                                            });
                                          }),
                                    ),
                                    SizedBox(height: 8),
                                    SizedBox(
                                      width: 250,
                                      height: 30,
                                      child: DropdownButtonFormField<String>(
                                          value: _member4.text.isNotEmpty
                                              ? _member4.text
                                              : null,
                                          //validator: (value) => _member4.text,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.person_outlined,
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: Color(0xFFCADCFF),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          items:
                                              usernames.map((String username) {
                                            return DropdownMenuItem<String>(
                                              value: username,
                                              child: Text(username),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _member4.text = newValue!;

                                              // Handle the selected value here
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /*Column(
                              children: [
                                for (int index = 0;
                                    index < members.length;
                                    index++)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              TextFormField(
                                                initialValue: members[index]
                                                    ['name'],
                                                readOnly: members[index]
                                                    ['readOnly'],
                                                decoration: InputDecoration(
                                                  hintText: 'Enter member name',
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical:
                                                              8), // Adjust the vertical padding
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                  ),
                                                ),
                                              ),
                                              if (!members[index]['readOnly'])
                                                Positioned(
                                                  right: 0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      removeMember(
                                                          members[index]['key']);
                                                    },
                                                    child: Container(
                                                      width: 32,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                      ),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 20,
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
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      if (members.length <= 3) {
                                        setState(() {
                                          int lastKey = members.last['key'];
                                          members.add({
                                            'name': '',
                                            'key': lastKey + 1,
                                            'readOnly': false,
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 140,
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
                                          'Add Member',
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
                            ),*/
                        ],
                      ),
                      SizedBox(height: 13),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              projectName = _projectName.text;
                            });
                            print(widget.username);
                            final x = await SQLHelper.addGroupDetails(
                                int.tryParse(_groupNo.text)!,
                                null,
                                widget.username,
                                _member2.text,
                                _member3.text,
                                _member4.text);

                            await SQLHelper.editUserGroupNo(
                                widget.username, int.tryParse(_groupNo.text)!);
                            await SQLHelper.editUserGroupNo(
                                _member2.text, int.tryParse(_groupNo.text)!);
                            await SQLHelper.editUserGroupNo(
                                _member3.text, int.tryParse(_groupNo.text)!);
                            await SQLHelper.editUserGroupNo(
                                _member4.text, int.tryParse(_groupNo.text)!);
                            await SQLHelper.addProject(
                                _groupNo.text, _projectName.text);

                            Navigator.pop(context, projectName);
                            //Navigator.pushNamed(/, routeName)// Add your logic here for the button's onTap event
                          },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  //I have added comments where changes are made. I reduced the vertical padding of the input fields by adding the `vertical` property to the `EdgeInsets.symmetric()` method. You can adjust the value of `vertical` as needed to achieve the desired height for the input fields.

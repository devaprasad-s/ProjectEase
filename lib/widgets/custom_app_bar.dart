import 'package:app_uno/db/sqlhelper.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
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
                  child: Stack(children: [
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton(itemBuilder: (context) {
                        return [
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text("Logout"),
                          ),
                        ];
                      }, onSelected: (value) async {
                        if (value == 0) {
                          // Navigate to the login page or any other desired screen
                          await SQLHelper.closeDatabase();
                          Navigator.pushNamed(context, '/');
                        }
                      }),
                    )
                  ]),
                ),
              ),
            ),
          )
        ]));
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}

import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  IconData drawericon;
  String drawertitle;
  Color? iconbgcolor;

  DrawerListTile({
    required this.drawericon,
    required this.drawertitle,
    required this.iconbgcolor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: MediaQuery.of(context).size.height * 0.045,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: iconbgcolor,
        ),
        child: Icon(
          drawericon,
          color: Colors.white,
        ),
      ),
      title: Text(
        drawertitle,
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}

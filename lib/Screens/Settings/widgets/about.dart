import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutDialogs extends StatelessWidget {
  String title;
  String name;
  String text1;
  String contact;
  String mail;
  AboutDialogs(
      {super.key,
      required this.title,
      required this.name,
      required this.text1,
      required this.contact,
      required this.mail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 217, 248, 248),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Color.fromARGB(255, 51, 75, 87)),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            name,
            style: GoogleFonts.acme(
                color: const Color.fromARGB(255, 195, 28, 16), fontSize: 30),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Text(
            text1,
            textAlign: TextAlign.center,
            style: const TextStyle(
                height: 1.5, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            contact,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(mail)
        ],
      ),
    );
  }
}

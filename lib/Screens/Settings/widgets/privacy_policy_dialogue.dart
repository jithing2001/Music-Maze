import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {
  String mdFileName;
  PolicyDialog({required this.mdFileName, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future:
                      Future.delayed(Duration(microseconds: 150)).then((value) {
                    return rootBundle.loadString('Assets/Images/$mdFileName');
                  }),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(data: snapshot.data.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }))),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'))
        ],
      ),
    );
  }
}

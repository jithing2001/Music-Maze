import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      Future.delayed(const Duration(microseconds: 150)).then((value) {
                    return rootBundle.loadString('Assets/Images/$mdFileName');
                  }),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(data: snapshot.data.toString());
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }))),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'))
        ],
      ),
    );
  }
}

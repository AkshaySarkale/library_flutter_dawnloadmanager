import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Dawnloadmanagerwithnotification extends StatefulWidget {
  final String dawnloadPath;
  final String dawnloadUrl;

  const Dawnloadmanagerwithnotification({
    super.key,
    this.dawnloadPath = "/storage/emulated/0/Dawnload/",
    required this.dawnloadUrl,
  });

  @override
  State<Dawnloadmanagerwithnotification> createState() =>
      _DawnloadmanagerwithnotificationState();
}

class _DawnloadmanagerwithnotificationState extends State<Dawnloadmanagerwithnotification> {
  void dawnloadFIle() async {
    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "${widget.dawnloadPath}";
    var file = File(path);
    var res = await http.get(Uri.parse(widget.dawnloadUrl));
    file.writeAsBytes(res.bodyBytes);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IconButton(
        onPressed: () {
          setState(() {
            dawnloadFIle();
          });
        },
        icon: Icon(Icons.filter_list_sharp),
      ),
    );
  }
}

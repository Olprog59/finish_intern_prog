import 'package:finish_intern_prog/services.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Hand extends StatefulWidget {
  final String id;
  final Map<dynamic, dynamic> data;
  const Hand({Key? key, required this.id, required this.data}) : super(key: key);

  @override
  _HandState createState() => _HandState();
}

class _HandState extends State<Hand> {
  String imgLink = "assets/img/dislike.png";
  Color color = Colors.red;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    windowManager.setSize(const Size(200, 200));
    windowManager.setResizable(false);
  }

  @override
  Widget build(BuildContext context) {
    final appw = ServiceAppwrite();
    final id = widget.id;
    final data = widget.data;

    return Material(
      color: color,
      child: IconButton(
        icon: Image.asset(
          imgLink,
          color: Colors.white,
          width: 128,
          height: 128,
        ),
        iconSize: 128,
        color: Colors.white,
        onPressed: () {
          setState(() {
            if (imgLink == "assets/img/like.png") {
              imgLink = "assets/img/dislike.png";
              color = Colors.red;
              data['finish'] = false;
              appw.documentUpdate(id, data);
            } else {
              imgLink = "assets/img/like.png";
              color = Colors.green;
              data['finish'] = true;
              appw.documentUpdate(id, data);
            }
          });
        },
      ),
    );
  }
}

import 'package:finish_intern_prog/user.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              minimumSize: const Size(150, 60),
            ),
            onPressed: () {
              windowManager.setSize(const Size(800, 300));
            },
            child: const Text("Administrateur"),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              minimumSize: const Size(150, 60),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const User()));
              // windowManager.setSize(const Size(300, 300));
            },
            child: const Text("Stagiaire"),
          )
        ],
      ),
    );
  }
}

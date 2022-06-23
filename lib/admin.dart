import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:finish_intern_prog/services.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    windowManager.setSize(const Size(800, 300));

    ServiceAppwrite appw = ServiceAppwrite();

    Client client = Client();
    client.setEndpoint('$URL/v1').setProject(PROJECT_ID);
    final realtime = Realtime(client);
    final subscription = realtime.subscribe(['collections.$DATABASE.documents']);

    subscription.stream.listen((data) {
      print('data payload : ${data.payload}');
      if (data.payload.isNotEmpty) {
        print('data events : ${data.events}');
      }
    });

    @override
    void initState() {
      super.initState();
      // Add code after super
    }

    return Material(
      child: FutureBuilder(
        future: appw.documentList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Document> list = snapshot.data.documents;
            return ListView(
              children: [
                ListTile(
                  leading: Text('\$id'),
                  title: Text('Prénom Nom'),
                ),
                ...list.map((e) => Card(
                      child: ListTile(
                        title: Text(e.data['firstname'] + ' ' + e.data['lastname']),
                        leading: Text(e.data['\$id']),
                        tileColor: e.data['finish'] as bool ? Colors.green.shade400 : Colors.red.shade400,
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ),
                    ))
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

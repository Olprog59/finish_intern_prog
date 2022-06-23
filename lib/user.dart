import 'package:finish_intern_prog/constants.dart';
import 'package:finish_intern_prog/hand.dart';
import 'package:finish_intern_prog/services.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final _formKey = GlobalKey<FormState>();

  final regName = RegExp(r'\w{3,}');

  String firstname = "";
  String lastname = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstname = prefs.getString("firstname") ?? "";
    lastname = prefs.getString("lastname") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: TextEditingController(text: firstname),
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Prénom"),
                  onChanged: (value) {
                    firstname = value.toLowerCase();
                  },
                  validator: (value) {
                    return testFieldName(value);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: TextEditingController(text: lastname),
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Nom"),
                  onChanged: (value) {
                    lastname = value.toLowerCase();
                  },
                  validator: (value) {
                    return testFieldName(value);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<dynamic, dynamic> data = {'firstname': firstname, 'lastname': lastname, 'finish': false};
                      print('rempli');
                      prefs.setString('firstname', firstname);
                      prefs.setString('lastname', lastname);
                      String id = $id(firstname, lastname);
                      final appw = ServiceAppwrite();
                      appw.documentGetOne(id).then((value) {
                        value.data['finish'] = false;
                        appw.documentUpdate(id, value.data);
                        data = value.data;
                      }).catchError((_) {
                        final doc = appw.documentCreate(id, data);
                        print(doc);
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Hand(id: id, data: data)));
                    } else {
                      print('KO');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                  ),
                  child: const Text("Valider"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? testFieldName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Il faut remplir le champ';
    } else if (!regName.hasMatch(value)) {
      return 'Un minimum de 3 caractères';
    }
    return null;
  }

  String $id(String firstname, String lastname) {
    return firstname.substring(0, 3) + lastname.substring(0, 3);
  }
}

import 'package:finish_intern_prog/constants.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: TextEditingController(text: firstname),
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Prénom"),
                  onChanged: (value) {
                    firstname = value.toLowerCase();
                  },
                  validator: (value) {
                    return testFieldName(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: TextEditingController(text: lastname),
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Nom"),
                  onChanged: (value) {
                    lastname = value.toLowerCase();
                  },
                  validator: (value) {
                    return testFieldName(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('rempli');
                      prefs.setString('firstname', firstname);
                      prefs.setString('lastname', lastname);
                      String id = $id(firstname, lastname);
                      final appw = ServiceAppwrite();
                      appw.documentGetOne(id).then((value) {
                        print(value.data);
                      }).catchError((_) {
                        final doc = appw.documentCreate(id, {'firstname': firstname, 'lastname': lastname});
                        print(doc);
                      });
                    } else {
                      print('KO');
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                  ),
                  child: const Text("Valider"),
                ),
              ],
            ),
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

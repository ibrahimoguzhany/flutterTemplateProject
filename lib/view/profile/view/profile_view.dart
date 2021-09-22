import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              errorStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

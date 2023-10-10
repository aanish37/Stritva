import 'package:flutter/material.dart';
import 'package:stritva/constant.dart';

class User {
  String username;
  String email;

  User(this.username, this.email);
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  User _user = User('john Doe', 'johndow@'); // Initial user data

  @override
  void initState() {
    super.initState();
    _usernameController.text = _user.username;
    _emailController.text = _user.email;
  }

  void _saveChanges() {
    setState(() {
      _user.username = _usernameController.text;
      _user.email = _emailController.text;
    });
    print("Updated User Data:");
    print("Username: ${_user.username}");
    print("Email: ${_user.email}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: "Username", focusColor: buttonColor),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                fillColor: buttonColor,
                labelText: "Email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_data.dart';
import 'package:stritva/constant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<UserData>(context, listen: false).user; // Initial user data

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
            ),
            onPressed: () {
              if (_usernameController.text.isEmpty) {
                _usernameController.text = user.username;
              }
              if (_emailController.text.isEmpty) {
                _emailController.text = user.email;
              }

              if (_usernameController.text.isEmpty ||
                  _emailController.text.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Please fill all the fields"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      );
                    });
              }

              Provider.of<UserData>(context, listen: false).addNameEmail(
                  _usernameController.text, _emailController.text);

              Navigator.pop(context);
            },
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
            const SizedBox(height: 16),
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

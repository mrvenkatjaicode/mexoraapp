import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void showAlertsuccess(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      btnOkOnPress: () {},
      title: 'SUCCESS',
      desc: 'Profile Saved successfully!',
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'User Name',
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF7F7F7),
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'User Mobile Number',
                prefixIcon: Icon(Icons.phone, color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF7F7F7),
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'User Email',
                prefixIcon: Icon(Icons.mail, color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF7F7F7),
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF03C27E),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  showAlertsuccess(context);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

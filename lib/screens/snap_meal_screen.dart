import 'package:flutter/material.dart';

class SnapMealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Snap Your Meal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Open Camera'),
            ),
          ],
        ),
      ),
    );
  }
}

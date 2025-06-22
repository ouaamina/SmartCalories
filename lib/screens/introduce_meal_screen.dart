import 'package:flutter/material.dart';

class IntroduceMealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Describe Your Meal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'E.g. 2 eggs and toast with butter',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Estimate Calories'),
            ),
          ],
        ),
      ),
    );
  }
}

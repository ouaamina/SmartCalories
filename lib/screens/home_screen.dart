import 'package:flutter/material.dart';

import '../widgets/MealItem.dart';
import '../widgets/weekCalender.dart';


class NutritionHomePage extends StatelessWidget {

  final List<Map<String, dynamic>> last7Days = List.generate(7, (index) {
    final date = DateTime.now().subtract(Duration(days: 6 - index));
    return {
      'day': ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7],
      'date': date.day,
      'calories': 1200 + (index * 50), // Dummy calorie data
      'isToday': date.day == DateTime.now().day
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Good morning!', style: TextStyle(color: Colors.grey)),
                    Text('Sajibur Rahman', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Spacer(),
                Icon(Icons.notifications_none),
              ],
            ),
          ),

          // Calendar
          WeeklyCalendar(
            onDateSelected: (selectedDate) {
              print("Selected: $selectedDate");
              // Update your meals or chart here
            },
          ),


          // Macro Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('87', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Protein', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('103', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Fat', style: TextStyle(color: Colors.purple)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('167', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Carbs', style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                  Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: 1566 / 2500,
                          backgroundColor: Colors.pink.shade100,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 6,
                        ),
                      ),
                      Text('1566\nkcal', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Meal List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                MealItem(
                  title: 'Lunch',
                  meals: [
                    {
                      'name': 'Salad with egg',
                      'calories': 294,
                      'weight': 100,
                      'protein': 25,
                      'fat': 21,
                      'carbs': 14,
                      'image': null,
                    },
                    {
                      'name': 'Grilled chicken',
                      'calories': 350,
                      'weight': 150,
                      'protein': 32,
                      'fat': 12,
                      'carbs': 0,
                      'image': null, // default icon used
                    },
                  ],
                ),
                MealItem(
                  title: 'Dinner',
                  meals: [
                    {
                      'name': 'Pasta with tomato sauce',
                      'calories': 450,
                      'weight': 200,
                      'protein': 12,
                      'fat': 8,
                      'carbs': 70,
                      'image': null,
                    },
                    {
                      'name': 'Steamed vegetables',
                      'calories': 150,
                      'weight': 100,
                      'protein': 5,
                      'fat': 2,
                      'carbs': 30,
                      'image': null, // default icon used
                    },
                  ],
                ),

              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
        ],
      ),
    );
  }

  Widget _mealItem(BuildContext context, String title, String subtitle, int? kcal, List<Map<String, dynamic>> meals) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(Icons.check_circle_outline, color: Colors.green),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: kcal != null ? Text('$kcal kcal') : Icon(Icons.add, color: Colors.green),
        onTap: () => _showMealDetails(context, title, meals),
      ),
    );
  }

  void _showMealDetails(BuildContext context, String title, List<Map<String, dynamic>> meals) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...meals.map((meal) => ListTile(
              leading: meal['image'] != null
                  ? Image.network(meal['image'], width: 40, height: 40, fit: BoxFit.cover)
                  : Icon(Icons.fastfood),
              title: Text(meal['name'] ?? ''),
              subtitle: meal['calories'] != null ? Text('${meal['calories']} kcal') : null,
            )),
          ],
        ),
      ),
    );
  }


}

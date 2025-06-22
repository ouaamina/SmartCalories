import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MealItem extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> meals;

  const MealItem({
    required this.title,
    required this.meals,
    Key? key,
  }) : super(key: key);

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get totalCalories {
    return widget.meals.fold(0, (sum, meal) => sum + ((meal['calories'] ?? 0) as num).toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      centerSpaceRadius: 18,
                      sectionsSpace: 2,
                      sections: [
                        PieChartSectionData(
                          color: Colors.teal,
                          value: totalCalories.toDouble().clamp(0, 2000),
                          radius: 10,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          color: Colors.grey.shade300,
                          value: (2000 - totalCalories).toDouble().clamp(0, 2000),
                          radius: 10,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text('$totalCalories kcal consumed',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.green),
                      onPressed: () {
                        // TODO: Trigger snap logic
                      },
                    ),
                    IconButton(
                      icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more, color: Colors.grey),
                      onPressed: () {
                        setState(() => _expanded = !_expanded);
                        _expanded ? _controller.forward() : _controller.reverse();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Column(
              children: widget.meals.map((meal) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: meal['image'] != null
                                ? Image.network(meal['image'], width: 40, height: 40, fit: BoxFit.cover)
                                : Icon(Icons.fastfood, size: 36, color: Colors.teal),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(meal['name'] ?? '',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.local_fire_department, size: 16, color: Colors.red),
                                    const SizedBox(width: 4),
                                    Text('${meal['calories']} kcal • ${meal['weight'] ?? '100'} g',
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _macroStat('Protein', meal['protein'] ?? 0, Colors.green),
                          _macroStat('Fat', meal['fat'] ?? 0, Colors.amber),
                          _macroStat('Carbs', meal['carbs'] ?? 0, Colors.pink.shade300),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _macroStat(String label, int value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Container(width: 4, height: 20, color: color),
            const SizedBox(width: 6),
            Text('$value g', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

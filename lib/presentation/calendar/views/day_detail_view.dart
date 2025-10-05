import 'package:flutter/material.dart';

class DayDetailView extends StatelessWidget {
  const DayDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day Detail')),
      body: const Center(
        child: Text('Details for the selected day will appear here.'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:harubee/presentation/today/today_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '하루비',
      theme: ThemeData(fontFamily: 'Pretendard'),
      home: const TodayView(),
    );
  }
}

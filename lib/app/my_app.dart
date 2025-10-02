import 'package:flutter/material.dart';
import 'package:harubee/core/navigation/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: '하루비',
      theme: ThemeData(fontFamily: 'Pretendard'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ProviderScope는 Riverpod 패키지에서 제공하는 위젯으로, 애플리케이션 전체에서 프로바이더 사용가능하도록 함
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Tito',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          //애플리케이션의 대표 테마 색상 -> const Color(0xFF8E48F8)
        ),
      ),
    );
  }
}

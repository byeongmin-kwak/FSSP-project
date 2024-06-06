import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:FSSP_cilent/screens/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String clientId = dotenv.get("CLIENT_ID");
  await NaverMapSdk.instance.initialize(clientId: clientId);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      home: const SplashScreen(), // 앱의 처음 화면을 스플래시 화면으로 설정합니다.
    );
  }
}

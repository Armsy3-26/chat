import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding();
  doWhenWindowReady(() {
    const initialSize = Size(360, 774);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.centerLeft;
    appWindow.title = "AliXe Suite";
    appWindow.show();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 774),
      builder: (_, c) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AliXe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ChatPage(),
      ),
    );
  }
}

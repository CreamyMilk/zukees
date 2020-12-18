import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zukes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Zuke';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
              fontSizeDelta: 1.0,
            ),

        //primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        accentColor: Colors.amber,
      ),
      darkTheme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
              fontSizeDelta: 1.0,
            ),
        primaryColor: Colors.black,
        accentColor: Colors.amber,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}

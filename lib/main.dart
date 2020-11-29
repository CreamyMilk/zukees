import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:zukes/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Hive.initFlutter();
  //   await Hive.openBox('demo');
  //   runApp(MyApp());
  // });
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
        primaryColor: Colors.black,
        accentColor: Colors.black38,
      ),
      darkTheme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
              fontSizeDelta: 1.0,
            ),
        primaryColor: Colors.black,
        accentColor: Colors.black38,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}

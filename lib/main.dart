import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/rent_amounts_provider.dart';
import 'package:zukes/providers/store_provider.dart';
import 'package:zukes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(MyApp());
}

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String appTitle = 'Zuke';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RentAmountP>(
              create: (context) => RentAmountP()),
          ChangeNotifierProvider<StoreProvider>(
              create: (context) => StoreProvider()),
        ],
        builder: (context, child) {
          return MaterialApp(
            title: appTitle,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme.apply(
                    fontSizeFactor: 0.75,
                    fontSizeDelta: 1.0,
                  ),
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
            navigatorKey: navKey,
          );
        });
  }
}

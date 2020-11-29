
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zukes/views/tabs_control.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => BaseTabView());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

}
class BaseRoute extends StatelessWidget {
  const BaseRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData d = MediaQuery.of(context);
    print("SCALEFACTOR >>>>${d.textScaleFactor}");
    return MediaQuery(
      data: d.copyWith(
        textScaleFactor:d.textScaleFactor.clamp(1.0,1.3),
      ),
      child: BaseTabView());
  }
}
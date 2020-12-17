import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zukes/pages/all_tens.dart';
import 'package:zukes/pages/hover_login.dart';
import 'package:zukes/pages/kraForm.dart';
import 'package:zukes/pages/list_products.dart';
//import 'package:zukes/pages/login_page.dart';
import 'package:zukes/pages/product_purchase.dart';
import 'package:zukes/providers/counter.dart';
import 'package:zukes/providers/kra_fromProvide.dart';
import 'package:zukes/views/tabs_control.dart';
import 'package:zukes/pages/all_tenants.dart';
import 'package:zukes/pages/otp_receiver.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<Counter>(
                create: (context) => Counter(),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        systemNavigationBarColor: Colors.black),
                    child: HoverLogin())));
      case '/verify':
        return MaterialPageRoute(
            builder: (ctx) => OtpReceiver(phonenumber: args));
      case '/home':
        return MaterialPageRoute(builder: (ctx) => BaseTabView());
      case '/alltens':
        return MaterialPageRoute(
            builder: (ctx) => AllTenatsTable(branch: args));
      case '/alltensu':
        return MaterialPageRoute(builder: (ctx) => DataTableExample());
      case '/kraform':
        return MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<KraFormProvider>(
                create: (context) => KraFormProvider(),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.teal[400],
                        systemNavigationBarColor: Colors.white),
                    child: BaseForm())));
      case '/products':
        return MaterialPageRoute(
            builder: (ctx) => ListProducts(
                  category: args,
                ));
      case '/product':
        return MaterialPageRoute(
            builder: (ctx) => ProductPage(
                  productID: args,
                ));
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

class BaseRoute extends StatefulWidget {
  const BaseRoute({Key key}) : super(key: key);

  @override
  _BaseRouteState createState() => _BaseRouteState();
}

class _BaseRouteState extends State<BaseRoute> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData d = MediaQuery.of(context);
    print("SCALEFACTOR >>>>${d.textScaleFactor}");
    return MediaQuery(
        data: d.copyWith(
            //textScaleFactor:d.textScaleFactor.clamp(2,10),
            devicePixelRatio: 1.0,
            textScaleFactor: 1),
        child: BaseTabView());
  }
}

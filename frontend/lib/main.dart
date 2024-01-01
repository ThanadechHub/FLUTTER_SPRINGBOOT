import 'package:flutter/material.dart';
import 'package:flutter_application/states/authen.dart';
import 'package:flutter_application/states/create_account.dart';
import 'package:flutter_application/states/service_admin.dart';
import 'package:flutter_application/states/service_user.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/serviceAdmin': (BuildContext context) => ServiceAdmin(),
  '/serviceUSer': (BuildContext context) => ServiceUser(),
};

String? initialRoute;

void main() {
  initialRoute = '/authen';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
      title: 'Tisco',
    );
  }
}

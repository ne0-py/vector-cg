import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_cg/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:vector_cg/services/auth.dart';
import 'package:vector_cg/widgets/add_activity_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black, // black status bar
        statusBarIconBrightness: Brightness.light));
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        home: Wrapper(),
        routes: {
          '/new_activity': (context) => ActivityForm(),
        },
      ),
    );
  }
}

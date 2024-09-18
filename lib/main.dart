//import 'package:DotechApp/services/push_notification_service.dart';
import 'package:DotLiving/views/Dashboard.dart';
import 'package:DotLiving/views/auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  //await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool sessionExist = false;
  bool modoOscuro = false;
  @override
  void initState() {
    super.initState();
    checkSession();
    checkModoOscuro();
  }

  void checkSession() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (localStorage.containsKey('auth_token')) {
      setState(() {
        sessionExist = true;
      });
    }
  }

  void checkModoOscuro() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('modo_oscuro')) {
      localStorage.setBool('modo_oscuro', modoOscuro);
    } else {
      modoOscuro = localStorage.getBool('modo_oscuro')!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DotLiving',
      theme: ThemeData(
        colorScheme:
            modoOscuro ? const ColorScheme.dark() : const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: sessionExist ? const Dashboard() : const Login(),
    );
  }
}

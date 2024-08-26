import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myride/utilities/home/home.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Ride',
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.grey,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.green,
          secondary: Colors.blue,
          surface: Colors.grey[900]!,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[100],
          foregroundColor: Colors.green,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: FutureBuilder<PermissionStatus>(
        future: Permission.location.request(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final locationStatus = snapshot.data;
            if (locationStatus == PermissionStatus.granted) {
              return const UserSelectionPage();
            } else if (locationStatus == PermissionStatus.denied) {
              return const Scaffold(
                body: Center(
                  child: Text('Location permission is required to use My Ride'),
                ),
              );
            } else if (locationStatus == PermissionStatus.permanentlyDenied) {
              openAppSettings();
              return Container();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('Unknown permission status'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
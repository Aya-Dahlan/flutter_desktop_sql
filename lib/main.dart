import 'package:flutter/material.dart';
import 'package:flutter_desktop_sql/Menu/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SqfliteFfiInit;
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //our defult
        fontFamily: GoogleFonts.ubuntuTextTheme.toString(),
        useMaterial3: true,
      ),
      home: const Menu(),
    );
  }
}

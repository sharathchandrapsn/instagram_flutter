import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/cart_provider.dart';
import 'package:instagram_flutter/providers/counter_provider.dart';
import 'package:instagram_flutter/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/screens/counter_screen_by_chatgpt.dart';
import 'package:instagram_flutter/screens/food_order_app.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/screens/login_screen_by_chatgpt.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/web_screen_layout.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAi-RX2TlukD-apH4Kih-QQCghosqq2sbI",
              appId: "1:1037385355485:web:d6eb75ca18c37cfcec0b34",
              messagingSenderId: "1037385355485",
              projectId: "instagram-flutter-e5d9a",
              storageBucket: "instagram-flutter-e5d9a.appspot.com"),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Instagram Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: primaryColor,
        ),
        // home: const ResponsiveLayout(
        //   webScreenLayout: WebScreen(),
        //   mobileScreenLayout: MobileScreen(),
        // ),
        // home: LoginScreen(),
        // home: LoginApp(),
        home: FoodOrderApp(),
      ),
    );
  }
}

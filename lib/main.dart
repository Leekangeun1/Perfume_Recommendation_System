import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:perfume_recsys/provider_data.dart';
import 'package:perfume_recsys/querypage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ListenableProvider(create: (context) => SearchData()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfume RecSystem',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Welcome To",
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Perfume Recommendation System",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
        Image.asset("img/perfumeBG.jpg"),
        const SizedBox(height: 30),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffb588cc),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QueryPage()));
            },
            child: Column(children: const [
              Text(
                "Start Recommendation!",
                style: TextStyle(fontSize: 17),
              ),
            ])),
        const SizedBox(height: 30),
      ],
    ));
  }
}

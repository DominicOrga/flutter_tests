import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Transaction Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder: (context) => MaterialButton(
                  onPressed: () => doTransaction(context),
                  color: Colors.blue,
                  child: Text(
                    'Test Firestore Transaction',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(message)
            ],
          ),
        ),
      ),
    );
  }

  void doTransaction(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final docRef = firestore.doc('Counter/counter');

    try {
      // Run a transaction.
      await firestore.runTransaction((transaction) async {
        Future.error('');
      });
    } catch (e) {
      print('AAAA $e');
    }
  }
}

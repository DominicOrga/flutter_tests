import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Throw Future.error()',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  try {
                    await firestore.runTransaction((transaction) async {
                      Future.error('test');
                    });
                  } catch (e) {
                    setState(() => message = e.toString());
                  }
                },
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Throw PlatformException()',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  try {
                    await firestore.runTransaction((transaction) async {
                      throw PlatformException(code: 'test');
                    });
                  } on PlatformException catch (e) {
                    setState(() => message = 'Platform exception: ${e.code}');
                  } on FirebaseException catch (e) {
                    setState(() => message = 'Firebase exception: ${e.code}');
                  } on Exception catch (e) {
                    setState(() => message = e.toString());
                  }
                },
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Throw FirebaseException()',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  try {
                    await firestore.runTransaction((transaction) async {
                      throw FirebaseException(code: 'test');
                    });
                  } on FirebaseException catch (e) {
                    setState(() => message = 'Firebase Exception ${e.code}');
                  } on Exception catch (e) {
                    setState(() => message = e.toString());
                  }
                },
              ),
              SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Throw Exception()',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  try {
                    await firestore.runTransaction((transaction) async {
                      throw Exception('test');
                    });
                  } catch (e) {
                    setState(() => message = e.toString());
                  }
                },
              ),
              SizedBox(height: 50),
              Text(message)
            ],
          ),
        ),
      ),
    );
  }
}

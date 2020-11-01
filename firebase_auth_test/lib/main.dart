import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  String userData;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.userChanges().listen((event) {
      setState(() => userData = event?.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    const email = 'tester32456@gmail.com';
    const password = '123456';

    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  child: const Text('Google Sign In'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    final googleSignInAccount = await GoogleSignIn().signIn();

                    if (googleSignInAccount == null) {
                      return;
                    }

                    final googleSignInAuthentication =
                        await googleSignInAccount.authentication;

                    final authCredential = GoogleAuthProvider.credential(
                      idToken: googleSignInAuthentication.idToken,
                      accessToken: googleSignInAuthentication.idToken,
                    );

                    final user = await FirebaseAuth.instance
                        .signInWithCredential(authCredential);
                  }),
              MaterialButton(
                  child: const Text('Register with Email & Password'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email, password: password);
                  }),
              MaterialButton(
                  child: const Text('Sign in with Email & Password'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, password: password);
                  }),
              MaterialButton(
                  child: const Text('Merge Email & Password to Google'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    final googleSignInAccount = await GoogleSignIn().signIn();

                    if (googleSignInAccount == null) {
                      return;
                    }

                    final googleSignInAuthentication =
                        await googleSignInAccount.authentication;

                    final authCredential = GoogleAuthProvider.credential(
                      idToken: googleSignInAuthentication.idToken,
                      accessToken: googleSignInAuthentication.idToken,
                    );

                    final userCredential = await FirebaseAuth.instance
                        .signInWithCredential(authCredential);

                    final emailAuthCredential = EmailAuthProvider.credential(
                        email: email, password: password);

                    userCredential.user.linkWithCredential(emailAuthCredential);
                  }),
              MaterialButton(
                  child: const Text('Merge Google to Email & Password'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);

                    final googleSignInAccount = await GoogleSignIn().signIn();

                    if (googleSignInAccount == null) {
                      return;
                    }

                    final googleSignInAuthentication =
                        await googleSignInAccount.authentication;

                    final authCredential = GoogleAuthProvider.credential(
                      idToken: googleSignInAuthentication.idToken,
                      accessToken: googleSignInAuthentication.idToken,
                    );

                    userCredential.user.linkWithCredential(authCredential);
                  }),
              MaterialButton(
                  child: const Text('Fetch sign in methods for email'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    userData = (await FirebaseAuth.instance
                            .fetchSignInMethodsForEmail(email))
                        .toString();
                    setState(() {});
                  }),
              MaterialButton(
                  child: const Text('Sign Out'),
                  color: Colors.blue.shade200,
                  onPressed: () async {
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();
                  }),
              const SizedBox(height: 20),
              Text('Message: ${userData}'),
            ],
          ),
        ),
      ),
    ));
  }
}

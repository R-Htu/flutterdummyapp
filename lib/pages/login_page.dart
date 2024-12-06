import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_app/components/my_textfield.dart';
import 'package:page_app/components/my_button.dart';
import 'package:page_app/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Function to handle user sign-in with email and password
  void signUserIn() async {
    String email = emailController.text;
    String password = passwordController.text;
    print("Email: $email");
    print("Password: $password");

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt Firebase sign-in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ensure the context is correct when closing the dialog
      Navigator.of(context, rootNavigator: true)
          .pop(); // Close loading dialog after success

      // Proceed with your next steps after successful sign-in
    } on FirebaseAuthException catch (e) {
      // Close loading dialog after failure
      Navigator.of(context, rootNavigator: true).pop();

      print('Error Code: ${e.code}');
      print('Error Message: ${e.message}');

      // Show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Authentication Error'),
            content:
                Text('The email or password is incorrect. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close error dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to handle Google Sign-In
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      return; // User canceled the login
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Show loading dialog while signing in
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt Firebase sign-in with Google credentials
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context, rootNavigator: true)
          .pop(); // Close loading dialog after success

      // Proceed with your next steps after successful sign-in
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true)
          .pop(); // Close loading dialog after failure

      print('Error Code: ${e.code}');
      print('Error Message: ${e.message}');

      // Show an error message if any
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Authentication Error'),
            content: Text('An error occurred during Google Sign-In.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close error dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 55, 55),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(Icons.lock, size: 100),
                SizedBox(height: 50),
                Text('Welcome back you\'ve been missed!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                SizedBox(height: 25),
                MyTextfield(
                  controller: emailController,
                  hinText: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  controller: passwordController,
                  hinText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 82, 84, 83),
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: signInWithGoogle, // Trigger Google sign-in
                    child: SquareTile(imagePath: 'assets/google.jpg'),
                  ),
                  const SizedBox(width: 20),
                  SquareTile(imagePath: 'assets/ios.jpg'),
                  const SizedBox(width: 20),
                  SquareTile(imagePath: 'assets/linkedin.jpg'),
                ]),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Not a member',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

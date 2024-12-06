import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_app/components/my_textfield.dart';
import 'package:page_app/components/my_button.dart';
import 'package:page_app/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
/*
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
*/
  // Function to handle user sign-up (registration)
  void signUserUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Check if password and confirm password match
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the error dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt Firebase user registration
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Pop the loading dialog immediately after successful registration
      Navigator.pop(context);

      // Proceed with your next steps after successful registration
      // For example, navigate to a new page, etc.
      // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

      print('User registered: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      // Pop the loading dialog if it wasn't already popped
      Navigator.pop(context);

      // Handle errors with a specific message
      print('Error Code: ${e.code}'); // Print the error code
      print('Error Message: ${e.message}'); // Print the error message

      // Show a generic error message dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registration Error'),
            content:
                Text(e.message ?? 'An error occurred during registration.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the error dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // Modified Google sign-in function
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      return;
    }
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Check if the Google user's email is already in Firebase
    try {
      // Check if the user is already signed in
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // If the email is already in Firebase, show alert
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Account Already Exists'),
              content: Text(
                  'There is already an account with the email: ${userCredential.user?.email}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the alert dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors here
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Google Sign-In Error'),
            content: Text(
                e.message ?? 'An error occurred while signing in with Google.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
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
      backgroundColor: const Color.fromARGB(255, 1, 35, 36),
      /* appBar: AppBar(
        title: const Text(
          'Dummy App',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap the whole body in a SingleChildScrollView
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 50),
                Text('Create your account!',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 246, 246, 246),
                        fontSize: 18)),
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
                MyTextfield(
                  controller: confirmPasswordController,
                  hinText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(height: 25),
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                  // This triggers the registration function
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 5,
                          color: const Color.fromARGB(255, 7, 7, 7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 82, 84, 83),
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 5,
                          color: const Color.fromARGB(255, 13, 13, 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: signInWithGoogle,
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
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap, // This triggers the login page
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
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

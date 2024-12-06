import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // This will remove the back arrow icon
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // Listen to auth state changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading spinner
          }

          final user = snapshot.data;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background image with BoxFit.contain to ensure the entire image fits
              Positioned.fill(
                child: Image.asset(
                  'assets/bears.png', // Ensure you have this image in your assets
                  fit: BoxFit
                      .contain, // Makes sure the entire image fits within the screen
                ),
              ),
              // Overlay to darken the background for text readability
              Container(
                color: const Color.fromARGB(255, 6, 77, 45)
                    .withOpacity(0.2), // Dark overlay for text visibility
              ),
              // Content on top of the background
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title text
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Safely access email only if user is signed in
                    user != null
                        ? Text(
                            "Logged In As: ${user.email!}",
                            style: TextStyle(
                              color: Color.fromARGB(255, 79, 202, 13),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'No user signed in',
                            style: TextStyle(
                              color: Color.fromARGB(255, 244, 9, 9),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    const SizedBox(height: 50),
                    // Bottom Navigation Bar content
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomNavigationBar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          showSelectedLabels: false, // Hide selected labels
                          showUnselectedLabels: false, // Hide unselected labels
                          items: const <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              icon: Icon(Icons.help, color: Colors.white),
                              label: 'Help', // This label won't show
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.coffee, color: Colors.white),
                              label: 'Coffee', // This label won't show
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.music_note, color: Colors.white),
                              label: 'Song', // This label won't show
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

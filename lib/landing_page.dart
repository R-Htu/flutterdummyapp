import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_app/meal/hmm_page.dart';
import 'package:page_app/pages/auth_page.dart';
import 'package:page_app/profile.dart';
import 'package:page_app/qr_code/qr_generator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  final List<String> _imageAssets = [
    'assets/bluebird.png',
    'assets/bird.png',
    'assets/whale.png',
  ];

  final List<Color> _colors = [
    const Color.fromARGB(136, 3, 77, 67),
    const Color.fromARGB(180, 81, 73, 186),
    const Color.fromARGB(135, 105, 158, 84),
  ];

  final List<String> _quotes = [
    "Believe in yourself!",
    "Stay positive, work hard, make it happen.",
    "Dream big and dare to fail.",
    "You are stronger than you think.",
  ];

  int _currentImageIndex = 0;
  Timer? _timer;
  Color _backgroundColor = const Color.fromARGB(171, 64, 100, 70);
  final Random _random = Random();
  String? _currentQuote;
  late AnimationController _animationController;
  final int _selectedIndex = 0;

  // Handle Bottom Navigation Bar taps
  void _onItemTapped(int index) {
    if (index == 1 || index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => index == 1 ? HmmPage() : const Profile()));
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Set up a periodic timer to change the image and color
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _changeImage();
    });

    _showQuote(); // Show initial quote
  }

  @override
  void dispose() {
    _timer?.cancel(); // Dispose of the timer
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  // Change image and background color
  void _changeImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imageAssets.length;
      _backgroundColor = _colors[_random.nextInt(_colors.length)];
    });

    _showQuote(); // Show a new quote every time the image changes
  }

  // Show a random quote with animation
  void _showQuote() {
    setState(() {
      _currentQuote = _quotes[_random.nextInt(_quotes.length)];
      _animationController.forward(from: 0.0); // Animate quote entrance
    });

    // Hide the quote after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuote != null) {
        setState(() {
          _currentQuote = null;
          _animationController.reverse(); // Animate quote exit
        });
      }
    });
  }

  // Dynamically return image path based on the current index
  String changeImage() {
    return _imageAssets[_currentImageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(7),
            topLeft: Radius.circular(6),
            topRight: Radius.circular(1),
          ),
          child: AppBar(
            backgroundColor: _backgroundColor.withOpacity(0.8),
            title: Center(
              child: Text(
                'Dummy App',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // QR Code and Sign Up buttons directly under the AppBar
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenerateCodePage(),
                      ),
                    );
                  },
                  child: const Text('QR Code'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthPage(),
                      ),
                    );
                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),

          // Background image with overlay
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    changeImage(),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                // Main content, including quote and image container
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Animated quote display
                        SizedBox(
                          height: 60,
                          child: _currentQuote != null
                              ? AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    double offset =
                                        1.0 - _animationController.value;
                                    return Transform.translate(
                                      offset: Offset(
                                          offset *
                                              MediaQuery.of(context).size.width,
                                          0),
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color:
                                              _backgroundColor.withOpacity(0.6),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(1),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Text(
                                          _currentQuote!,
                                          style: GoogleFonts.lora(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox.shrink(),
                        ),

                        // Image Container with Circular Shape and Fit.cover
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: ClipOval(
                            child: GestureDetector(
                              onTap: _changeImage,
                              child: Container(
                                width: 235,
                                height: 235,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        _imageAssets[_currentImageIndex]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _backgroundColor.withOpacity(0.6),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(0),
            bottom: Radius.circular(0),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Hello World',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Collection',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 10,
        ),
      ),
    );
  }
}

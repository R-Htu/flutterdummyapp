import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GenerateCodePage extends StatefulWidget {
  const GenerateCodePage({super.key});

  @override
  State<GenerateCodePage> createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  // 1. Create a TextEditingController to manage the input field text.
  final TextEditingController _controller = TextEditingController();
  String? qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Generate QR Code',
          style: TextStyle(
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(0, 252, 244, 244),
        flexibleSpace: Stack(
          children: [
            Image.asset(
              'assets/flowers.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: const Color.fromARGB(203, 112, 7, 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/scan");
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Color.fromARGB(255, 8, 8, 8),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TextField for input
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                // 2. Use the TextEditingController
                controller: _controller,
                onSubmitted: (value) {
                  setState(() {
                    qrData = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your data...',
                  hintStyle: TextStyle(
                    color: Colors.pink.shade200,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                ),
              ),
            ),
            SizedBox(height: 40),
            // 3. If qrData is provided, generate the QR code with a fixed size
            if (qrData != null)
              SizedBox(
                width: 200.0, // Set width of the QR code
                height: 200.0, // Set height of the QR code
                child: PrettyQrView.data(
                  data: qrData!, // QR code content
                  errorCorrectLevel:
                      QrErrorCorrectLevel.M, // Optional: Error correction level
                ),
              ),
            SizedBox(height: 20),
            // 4. Button to clear the TextField and QR code
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.clear(); // Clear the TextField
                  qrData = null; // Clear the generated QR code
                });
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Don't forget to dispose the controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}

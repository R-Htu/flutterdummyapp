

/*class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  bool isScanning = false; // To show scanning state to user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan QR Code',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins', // Corrected font family
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(49, 84, 3, 44),
        flexibleSpace: Stack(
          children: [
            Image.asset(
              'assets/flowers.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: const Color.fromARGB(233, 34, 67, 120),
            ),
          ],
          /* fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,*/
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generate");
            },
            icon: const Icon(
              Icons.qr_code,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: true,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;

              if (barcodes.isEmpty) {
                return;
              }

              setState(() {
                isScanning = false; // Stop scanning after a barcode is detected
              });

              // Handle the barcode detection
              for (final barcode in barcodes) {
                print('Barcode found! ${barcode.rawValue}');
                _showBarcodeDialog(barcode.rawValue, image);
              }
            },
          ),
          if (isScanning)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      //bottomNavigationBar: Contai,
      /* bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _backgroundColor.withOpacity(0.6),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0), bottom: Radius.circular(5.0)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
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
        ),  */
    );
  }

  void _showBarcodeDialog(String? barcodeValue, Uint8List? image) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(barcodeValue ?? 'No data'),
          content: image != null
              ? Image.memory(image)
              : const Text('No image captured'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isScanning =
                      true; // Start scanning again after closing the dialog
                });
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
*/
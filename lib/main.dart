import 'package:flutter/material.dart';

void main() {
  runApp(const SimpsonsUiApp());
}

class SimpsonsUiApp extends StatelessWidget {
  const SimpsonsUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpsons App UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        scaffoldBackgroundColor: const Color(0xFFFFD90F), 
        useMaterial3: true,
      ),
      home: const SimpsonsSearchScreen(),
    );
  }
}

class SimpsonsSearchScreen extends StatefulWidget {
  const SimpsonsSearchScreen({super.key});

  @override
  State<SimpsonsSearchScreen> createState() => _SimpsonsSearchScreenState();
}

class _SimpsonsSearchScreenState extends State<SimpsonsSearchScreen> {
  
  bool _isSearching = false;
  bool _hasResult = false;

  
  void _simulateSearch() {
    FocusScope.of(context).unfocus(); 
    
    setState(() {
      _isSearching = true;
      _hasResult = false;
    });

    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSearching = false;
        _hasResult = true; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscador de Capítulos',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFFFFD90F),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 3), 
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 0, 
                  ),
                ],
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Ingresa un ID (Ej: 12)',
                  hintStyle: const TextStyle(color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.black, size: 30),
                    onPressed: _simulateSearch,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            
            if (_isSearching)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.black, 
                  strokeWidth: 5,
                ),
              )
            else if (_hasResult)
              
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF70D1FE), 
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(6, 6),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '"Homero el Grande"', 
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(2, 2)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/en/thumb/0/0d/Simpsons_FamilyPicture.png/220px-Simpsons_FamilyPicture.png',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              
              const Center(
                child: Text(
                  '¡Ingresa el ID de un\ncapítulo para empezar!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:busqueda_capitulos_simpson/models/episode.dart';
import 'package:busqueda_capitulos_simpson/services/simpsons_service.dart';

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
  
  final TextEditingController _idController = TextEditingController();
  final SimpsonsService _simpsonsService = SimpsonsService();
  
  bool _isSearching = false;
  bool _hasResult = false;
  Episode? _episode;

  
  Future<void> _searchEpisode() async {
    FocusScope.of(context).unfocus(); 
    
    final String input = _idController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _isSearching = true;
      _hasResult = false;
      _episode = null;
    });

    final int? id = int.tryParse(input);
    
    if (id != null) {
      final result = await _simpsonsService.getEpisodeById(id);
      setState(() {
        _episode = result;
        _hasResult = true; // Se completó la búsqueda (con o sin éxito)
      });
    }

    setState(() {
      _isSearching = false;
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
      body: SingleChildScrollView(
        child: Padding(
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
                controller: _idController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Ingresa un ID (Ej: 12)',
                  hintStyle: const TextStyle(color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.black, size: 30),
                    onPressed: _searchEpisode,
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
            else if (_hasResult && _episode != null)
              
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
                        'RESULTADO:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '"${_episode!.name}"', 
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
                            _episode!.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) => 
                              const Center(child: Padding(padding: EdgeInsets.all(20), child: Icon(Icons.broken_image, size: 50))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Detalles adicionales
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoBadge('Temp: ${_episode!.season}'),
                          const SizedBox(width: 15),
                          _buildInfoBadge('Cap: ${_episode!.episodeNumber}'),
                        ],
                      ),
                      
                      const SizedBox(height: 15),
                      
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _episode!.synopsis,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Emitido: ${_episode!.airDate}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontStyle: FontStyle.italic
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (_hasResult && _episode == null)
               // Mensaje de error si no se encuentra
               Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.red, width: 3),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.error_outline, size: 50, color: Colors.red),
                      SizedBox(height: 10),
                      Text(
                        '¡D\'oh!\nNo encontramos ese capítulo.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
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
      ),
    );
  }

  Widget _buildInfoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD90F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(2, 2)),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
      ),
    );
  }
}
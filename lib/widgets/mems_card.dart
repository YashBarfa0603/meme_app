import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class MemeCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int ups;
  final String postLink;
  final Function(Color) onColorExtracted;

  const MemeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.ups,
    required this.postLink,
    required this.onColorExtracted,
  });

  @override
  State<MemeCard> createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
  Color backgroundColor = Colors.white;


  Future<void> extractDominantColor() async {
    
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(widget.imageUrl),
      );
      
      setState(() {
       backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.white; 
      });

      widget.onColorExtracted(backgroundColor);
    
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [backgroundColor, backgroundColor.withOpacity(0.7)]), borderRadius: BorderRadius.circular(12.0)),
        child: Padding(padding: const EdgeInsets.all(8),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl, placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            ),

            Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
          ],
        ),
        ),
      ),
    );
  }
}

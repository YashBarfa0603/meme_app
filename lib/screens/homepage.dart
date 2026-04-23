import 'package:flutter/material.dart';
import 'package:meme_app/models/meme_model.dart';
import 'package:meme_app/widgets/mems_card.dart';
import 'package:meme_app/services/meme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Meme> memes = [];
  bool isLoading = true;
  Color backgroundColor = Colors.deepPurple;

  @override
  void initState() {
    super.initState();
    fetchMemes();
  }

  Future<void> fetchMemes() async{
    final fetchMemes = await MemeServices().fetchMemes(context);
    setState(() {
      memes = fetchMemes ?? [];
      isLoading = false;
    });
  }

  void updateBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme App'),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : memes.isEmpty
            ? const Center(child: Text('No memes found'))
            : ListView.builder(
                itemCount: memes.length,
                itemBuilder: (context, index) {
                  final meme = memes[index];
                  return MemeCard(
                    title: meme.title,
                    imageUrl: meme.url,
                    ups: meme.ups,
                    postLink: meme.postLink,
                    onColorExtracted: updateBackgroundColor,
                  );
                },
              ),
      ),
    );
  }
}

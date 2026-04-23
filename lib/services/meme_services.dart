import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meme_app/models/meme_model.dart';
import 'package:http/http.dart' as http;

class MemeServices {


  Future <List<Meme>?> fetchMemes(BuildContext context) async {
    final url = Uri.parse('https://meme-api.com/gimme/wholesomememes/50');

    try{
      final response = await http.get(url);

      if(response.statusCode ==200){
        final data = json.decode(response.body) as Map<String, dynamic>;
        final memes = (data['memes'] as List<dynamic>);
        return memes.map((memeJson) => Meme.fromJson(memeJson as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Error fetching memes')),
      );
      return null;
    }
  }
}
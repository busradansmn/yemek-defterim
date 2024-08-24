import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Veri Çekme',
      home: YemekTarifi(),
    );
  }
}

class YemekTarifi extends StatefulWidget {
  @override
  _YemekTarifiState createState() => _YemekTarifiState();
}

class _YemekTarifiState extends State<YemekTarifi> {
  final TextEditingController _searchController = TextEditingController();
  String recipeDocumentId = ''; // Kullanıcının girdiği metni bu değişkende tutacağız
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif Arama'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                // Kullanıcının girdiği metni her değiştirdiğinde güncelle
                setState(() {
                  recipeDocumentId = value;
                  isSearching = true;
                });
              },
              decoration: InputDecoration(
                labelText: 'Yemek Adı Girin',
              ),
            ),
          ),
          Expanded(
            child: isSearching
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('yemekTarifleri').doc(recipeDocumentId).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var recipeData = snapshot.data!;
                      var name = recipeData['ad'];
                      var image = recipeData['resim'];
                      var rating = recipeData['puan'];
                      var description = recipeData['tarif'];
                      var ingredients = List<String>.from(recipeData['malzeme'] ?? []);

                      return RecipeDetail(
                        name: name,
                        image: image,
                        rating: rating,
                        description: description,
                        ingredients: ingredients,
                      );
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

class RecipeDetail extends StatelessWidget {
  final String name;
  final String image;
  final int rating;
  final String description;
  final List<String> ingredients;

  RecipeDetail({
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Puan: $rating', style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                Text(
                  'Malzeme:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ingredients.map((ingredient) {
                    return Text('- $ingredient', style: TextStyle(fontSize: 16));
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

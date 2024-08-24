import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Veri Çekme',
      home: yemek8(),
    );
  }
}

class yemek8 extends StatefulWidget {
  @override
  _Yemek1State createState() => _Yemek1State();
}

class _Yemek1State extends State<yemek8> {
  String recipeDocumentId = 'cokertme'; // Firestore doküman ID'sini kendi tarifinizle değiştirin.
  int favValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif Detayı'),
      ),
      body: StreamBuilder(
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
          var ingredients = List<String>.from(recipeData['malzeme'] ?? []); // Firebase'den gelen diziye dönüşüm
          favValue = recipeData['fav'] ?? 0;

          return RecipeDetail(
            name: name,
            image: image,
            rating: rating,
            description: description,
            ingredients: ingredients,
            favValue: favValue,
            onFavPressed: () {
              _updateFavValue();
            },
          );
        },
      ),
    );
  }

  void _updateFavValue() {
    int newFavValue = (favValue == 1) ? 0 : 1;

    FirebaseFirestore.instance.collection('yemekTarifleri').doc(recipeDocumentId).update({
      'fav': newFavValue,
    }).then((_) {
      setState(() {
        favValue = newFavValue;
      });
      print('Favori işlemi başarıyla tamamlandı.');
    }).catchError((error) {
      print('Favori işlemi sırasında bir hata oluştu: $error');
    });
  }
}

class RecipeDetail extends StatelessWidget {
  final String name;
  final String image;
  final int rating;
  final String description;
  final List<String> ingredients;
  final int favValue;
  final VoidCallback onFavPressed;

  RecipeDetail({
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.favValue,
    required this.onFavPressed,
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
                Row(
                  children: [
                    Text('Puan: $rating', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 8),
                    Icon(
                      favValue == 1 ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ],
                ),
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
                SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: onFavPressed,
                  child: Icon(Icons.favorite),
                  backgroundColor: favValue == 1 ? Colors.red : Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

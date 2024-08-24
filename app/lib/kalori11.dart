import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Veri Çekme',
      home: kalori11(),
    );
  }
}

class kalori11 extends StatefulWidget {
  @override
  _Yemek1State createState() => _Yemek1State();
}

class _Yemek1State extends State<kalori11> {
  String recipeDocumentId = 'adana kebap'; // Firestore doküman ID'sini kendi tarifinizle değiştirin.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KALORİ'),
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
          var calories = recipeData['kalori'] ?? []; // Firebase'den gelen kalori array'i
          
          return RecipeDetail(
            name: name,
            image: image,
            calories: calories,
          );
        },
      ),
    );
  }
}

class RecipeDetail extends StatelessWidget {
  final String name;
  final String image;
  final List<dynamic> calories; // Kalori array'i

  RecipeDetail({
    required this.name,
    required this.image,
    required this.calories,
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
                SizedBox(height: 16),
                Text(
                  'Kalori:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: calories.map((calorie) {
                    return Text('- $calorie kalori', style: TextStyle(fontSize: 16));
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

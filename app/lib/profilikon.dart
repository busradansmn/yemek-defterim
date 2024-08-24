import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? ad, soyad;

  @override
  void initState() {
    super.initState();
    // initState içinde kontrol işlemini başlat
    checkAndDisplayUserData();
  }

  Future<void> checkAndDisplayUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Kullanıcının e-posta adresini al
      String userEmail = user.email!;

      // Firestore'dan tüm belgeleri al
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('kullanicilar')
          .get();
 
      // Her belgeyi kontrol et
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;

        // Eğer e-posta bilgisi ile eşleşiyorsa, ad ve soyad bilgilerini ekrana bas
        if (userData['email'] == userEmail) {
          setState(() {
            ad = userData['ad'];
            soyad = userData['soyad'];
          });
        }
      });
    } else {
      print('Kullanıcı girişi yapılmamış.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 249, 142, 28),
        title: Text("FAVORİ TARİFLER"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Merhaba, ${ad ?? 'Misafir'} ${soyad ?? ''}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('yemekTarifleri').where('fav', isEqualTo: 1).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("Favori tarif bulunamadı."),
                  );
                }

                var favoriteRecipes = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    var recipe = favoriteRecipes[index].data() as Map<String, dynamic>;

                    var recipeName = recipe['ad'];
                    var recipeImage = recipe['resim'];
                    var recipeDescription = recipe['tarif'];

                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            recipeImage,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipeName,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(recipeDescription),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

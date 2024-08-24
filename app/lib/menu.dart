import 'package:app/arama.dart';
import 'package:app/kalori.dart';
import 'package:app/nepisirsem.dart';
import 'package:app/profilikon.dart';
import 'package:app/tarifler.dart';
import 'package:app/trendler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Menu());
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/dene.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              // İlk satır
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // TRENDLER
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 190,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "lib/assets/images/tarif2.jpg",
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TRENDLER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // TARİFLER
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => urunler()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                  
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 190,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "lib/assets/images/tarif1.jpg",
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TARİFLER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // İkinci satır
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // GÜNÜN MENÜSÜ
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BugunNePisirsemSayfasi()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                    
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 190,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "lib/assets/images/gunun.jpg",
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "GÜNÜN\nMENÜSÜ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // KAÇ KALORİ
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kalori()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                    
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 190,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            "lib/assets/images/kalori.jpg",
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "KAÇ KALORİ?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // İkonlar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Anasayfa
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Menu()),
                      );
                    },
                    iconSize: 50,
                  ),
                  // Arama
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    iconSize: 50,
                  ),
                  // Profil
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      print("Profil ikonuna tıklandı.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyLoginScreen()),
                      );
                    },
                    iconSize: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _registerUser(BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    User? user = userCredential.user;
    if (user != null) {
      // Kullanıcı başarıyla oluşturuldu, ad ve soyad bilgilerini Firestore'a kaydet
      await FirebaseFirestore.instance.collection('kullanicilar').doc(user.uid).set({
        'ad': _nameController.text,
        'soyad': _surnameController.text,
        'email': _emailController.text,
        // Diğer gerekli bilgileri ekleyebilirsiniz.
      });

      print("Kullanıcı oluşturuldu: ${user.uid}");
    }
  } catch (e) {
    // Kullanıcı oluşturma sırasında bir hata oluştu, isteğinize göre hata durumunu işleyin.
    print("Hata: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Oluştur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ad Soyad Girişleri
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Ad",
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      hintText: "Soyad",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // E-posta ve Şifre Girişleri
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "E-posta",
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Şifre",
              ),
            ),
            const SizedBox(height: 20.0),
            // Kayıt Ol Butonu
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.green,
                onPressed: () {
                  // Firebase'e kayıt olma işlemleri burada yapılacak
                  _registerUser(context);
                  Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Menu()));
                },
                child: const Text("Kayıt Ol"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

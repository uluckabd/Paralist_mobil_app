import 'package:flutter/material.dart';
import 'package:paralist/Anasayfa.dart';
import 'package:paralist/Kayit_Sayfasi.dart';
import 'package:paralist/Kullanicidao.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final TextEditingController kullaniciAdiController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();

  void girisyap(String kullaniciadi, String sifre) async {
    bool varMi = await Kullanicidao().kullaniciVarMi(kullaniciadi, sifre);
    if (varMi) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Anasayfa()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kullanıcı adı veya şifre yanlış.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "PARALİST",
          style: TextStyle(
            color: const Color.fromARGB(255, 226, 104, 247),
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("resimler/girisfotoo.png", fit: BoxFit.cover),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: kullaniciAdiController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "kullanıcı adınızı giriniz",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 66, 62, 62),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "şifrenizi giriniz",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 66, 62, 62),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 209, 108, 227),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  String kullaniciadi = kullaniciAdiController.text.trim();
                  String sifre = sifreController.text.trim();

                  if (kullaniciadi.isEmpty || sifre.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Lütfen tüm alanları doldurun.")),
                    );
                    return;
                  }

                  girisyap(kullaniciadi, sifre);
                },
                child: Text("giriş yap"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KayitSayfasi()),
                  );
                },
                child: Text(
                  "kayıt ol",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

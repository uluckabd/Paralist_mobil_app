import 'package:flutter/material.dart';
import 'package:paralist/Giris_Sayfasi.dart';
import 'package:paralist/Kullanicidao.dart';

class KayitSayfasi extends StatefulWidget {
  const KayitSayfasi({super.key});

  @override
  State<KayitSayfasi> createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  final TextEditingController kullaniciadikontrol = TextEditingController();
  final TextEditingController sifrekontrol = TextEditingController();
  final TextEditingController sifretekrarkontrol = TextEditingController();

  Future<void> kayitol() async {
    String kullaniciadi = kullaniciadikontrol.text.trim();
    String sifre = sifrekontrol.text.trim();

    await Kullanicidao().kullaniciekle(kullaniciadi, sifre);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Kayıt başarılı")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("KAYIT OL"),
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
                  controller: kullaniciadikontrol,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "Kullanıcı adınızı giriniz",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 44, 40, 40),
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
                  controller: sifrekontrol,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "Şifrenizi giriniz",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 44, 40, 40),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: sifretekrarkontrol,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintText: "Şifrenizi tekrar giriniz",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 44, 40, 40),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Geri Dön"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String kullaniciAdi = kullaniciadikontrol.text.trim();
                      String sifre = sifrekontrol.text.trim();
                      String sifretekrar = sifretekrarkontrol.text.trim();

                      if (kullaniciAdi.isEmpty ||
                          sifre.isEmpty ||
                          sifretekrar.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Lütfen tüm alanları doldurunuz"),
                          ),
                        );
                      } else {
                        if (sifre == sifretekrar) {
                          await kayitol();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GirisSayfasi(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "şifre ve şifre tekrar uyuşmuyor.tekrar deneyiniz",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Text("Kayıt Ol"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

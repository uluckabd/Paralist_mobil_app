import 'package:flutter/material.dart';
import 'package:paralist/Anasayfa.dart';

class Hakkinda extends StatefulWidget {
  const Hakkinda({super.key});

  @override
  State<Hakkinda> createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 148, 88, 4),
        title: Text("HAKKINDA", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("resimler/hakkinda.png", fit: BoxFit.cover),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.brown, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.85),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Paralist, günlük gelir ve harcamalarını kolayca not alabileceğin sade ve kullanışlı bir uygulamadır."
                        "Nereden ne kadar gelir elde ettiğini ve nereye para harcadığını unutmamak için not almak en iyisidir."
                        "Uygulamanın sade tasarımı sayesinde birkaç dokunuşla tüm gelir ve giderlerini kayıt altına alabilir, geçmişe dönüp finansal durumunu kolayca takip edebilir ve dilediğin kayıtları silebilirsin."
                        "Haydi, sen de bugünden itibaren Paralist ile gelir ve giderlerini kontrol altına al!",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Anasayfa()),
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text("Anasayfaya Dön"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 148, 88, 4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:paralist/gelirgiderdao.dart';

class Gider extends StatefulWidget {
  const Gider({super.key});

  @override
  State<Gider> createState() => _GiderState();
}

class _GiderState extends State<Gider> {
  List<Map<String, dynamic>> giderListesi = [];

  void verileriiGetir() async {
    var dao = Gelirgiderdao();
    var liste = await dao.tumgiderlerial();
    setState(() {
      giderListesi = liste;
    });
  }

  Future<void> giderSil(int giderId) async {
    var dao = Gelirgiderdao();
    await dao.giderSil(giderId);
    verileriiGetir();
  }

  @override
  void initState() {
    super.initState();
    verileriiGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF6A1B9A),
        elevation: 0,
        title: Text("Giderlerim", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(giderListesi.length, (index) {
            var gelir = giderListesi[index];

            return Card(
              color: Color(0xFFEDE7F6),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: Icon(Icons.arrow_downward, color: Colors.red.shade400),
                title: Text(
                  gelir["gider_baslik"],
                  style: const TextStyle(color: Colors.black87),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${gelir["gider_miktar"]} ₺",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    Text(
                      gelir["gider_aciklama"],
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'sil') {
                      giderSil(gelir["gider_id"]);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(value: 'sil', child: Text("Sil")),
                  ],
                  icon: Icon(Icons.more_vert, color: Colors.black54),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

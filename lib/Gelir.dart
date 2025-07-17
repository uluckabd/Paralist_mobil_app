import 'package:flutter/material.dart';
import 'package:paralist/gelirgiderdao.dart';

class Gelir extends StatefulWidget {
  const Gelir({super.key});

  @override
  State<Gelir> createState() => _GelirState();
}

class _GelirState extends State<Gelir> {
  List<Map<String, dynamic>> gelirListesi = [];

  void verileriGetir() async {
    var dao = Gelirgiderdao();
    var liste = await dao.tumGelirleriAl();
    setState(() {
      gelirListesi = liste;
    });
  }

  Future<void> gelirSil(int gelirId) async {
    var dao = Gelirgiderdao();
    await dao.gelirSil(gelirId);
    verileriGetir();
  }

  @override
  void initState() {
    super.initState();
    verileriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF6A1B9A),
        elevation: 0,
        title: Text("Gelirlerim", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(gelirListesi.length, (index) {
            var gelir = gelirListesi[index];

            return Card(
              color: Color(0xFFEDE7F6),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: Icon(Icons.arrow_upward, color: Colors.green.shade600),
                title: Text(
                  gelir["gelir_baslik"],
                  style: const TextStyle(color: Colors.black87),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${gelir["gelir_miktar"]} ₺",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    Text(
                      gelir["gelir_aciklama"],
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'sil') {
                      gelirSil(gelir["gelir_id"]);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: 'sil',
                      child: Text("Sil"),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert, color: Colors.black54),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

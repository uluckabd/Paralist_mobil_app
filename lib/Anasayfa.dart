import 'package:flutter/material.dart';
import 'package:paralist/Gelir.dart';
import 'package:paralist/Gider.dart';
import 'package:paralist/Giris_sayfasi.dart';
import 'package:paralist/Hakkinda.dart';
import 'package:paralist/gelirgiderdao.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  List<Map<String, dynamic>> giderListesi = [];
  void verileriiGetir() async {
    var dao = Gelirgiderdao();
    var liste = await dao.tumgiderlerial();
    setState(() {
      giderListesi = liste;
    });
  }

  List<Map<String, dynamic>> gelirListesi = [];
  void verileriGetir() async {
    var dao = Gelirgiderdao();
    var liste = await dao.tumGelirleriAl();
    setState(() {
      gelirListesi = liste;
    });
  }

  void initState() {
    super.initState();
    verileriGetir();
    verileriiGetir();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController baslikctrl = TextEditingController();
    TextEditingController miktarctrl = TextEditingController();
    TextEditingController aciklamactrl = TextEditingController();

    double genislik = MediaQuery.of(context).size.width;
    double yukseklik = MediaQuery.of(context).size.height;

    double toplamGelir = gelirListesi.fold(
      0,
      (toplam, item) => toplam + (item['gelir_miktar'] ?? 0),
    );
    double toplamGider = giderListesi.fold(
      0,
      (toplam, item) => toplam + (item['gider_miktar'] ?? 0),
    );

    double oran = (toplamGelir > 0) ? (toplamGider / toplamGelir) : 0;
    int bakiye = toplamGelir.toInt() - toplamGider.toInt();
    if (oran > 1) oran = 1;
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF6A1B9A),
        elevation: 0,
        title: Text("Anasayfa", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GirisSayfasi()),
              );
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 20,
        shadowColor: Colors.black,
        width: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      "MENÜ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                ),
                ListTile(
                  title: Text(
                    "Anasayfa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (Context) => Anasayfa()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Gelirlerim",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Gelir()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Giderlerim",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Gider()),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Hakkında",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (Context) => Hakkinda()),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              title: Text(
                "  KAPAT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Container(
                color: const Color(0xFFEDE7F6),
                width: genislik,
                height: yukseklik / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 12.0,
                      percent: oran,
                      center: Text(
                        "%${(oran * 100).toStringAsFixed(1)} Gider",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: Colors.deepPurpleAccent,
                      backgroundColor: Colors.deepPurple.shade100,
                      animation: true,
                      animationDuration: 1000,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.deepPurpleAccent,
                        ),
                        SizedBox(width: 8),
                        Text("Gider", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 24),
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.deepPurple.shade300,
                        ),
                        SizedBox(width: 8),
                        Text("Gelir", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Gelir ekle"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: baslikctrl,
                            decoration: InputDecoration(
                              labelText: "Başlık",
                              hintText: "Gelir başlığı",
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: miktarctrl,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: "Miktar",
                              hintText: "Örn: 1500",
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: aciklamactrl,
                            decoration: InputDecoration(
                              labelText: "Açıklama",
                              hintText: "Gelir açıklaması",
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("İptal"),
                        ),
                        TextButton(
                          onPressed: () async {
                            String gelirbaslik = baslikctrl.text;
                            int gelirmiktar =
                                int.tryParse(miktarctrl.text) ?? 0;
                            String geliraciklama = aciklamactrl.text;

                            var dao = Gelirgiderdao();
                            await dao.gelirekle(
                              gelirbaslik,
                              gelirmiktar,
                              geliraciklama,
                            );
                            Navigator.of(context).pop();
                            verileriGetir();
                          },
                          child: Text("Tamam"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_upward_outlined,
                        size: 30,
                        color: Colors.green.shade600,
                      ),
                      Expanded(
                        child: Container(
                          height: 58,
                          alignment: Alignment.center,
                          child: Text("Gelir ekle"),
                        ),
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Gider Ekle"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: baslikctrl,
                            decoration: InputDecoration(
                              labelText: "Başlık",
                              hintText: "Gider başlığı",
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: miktarctrl,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: "Miktar",
                              hintText: "Örn: 1500",
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: aciklamactrl,
                            decoration: InputDecoration(
                              labelText: "Açıklama",
                              hintText: "Gider açıklaması",
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("İptal"),
                        ),
                        TextButton(
                          onPressed: () async {
                            String giderbaslik = baslikctrl.text;
                            int gidermiktar =
                                int.tryParse(miktarctrl.text) ?? 0;
                            String gideraciklama = aciklamactrl.text;

                            var dao = Gelirgiderdao();
                            await dao.giderekle(
                              giderbaslik,
                              gidermiktar,
                              gideraciklama,
                            );
                            Navigator.of(context).pop();
                            verileriiGetir();
                          },
                          child: Text("Tamam"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 30,
                        color: Colors.red.shade400,
                      ),
                      Expanded(
                        child: Container(
                          height: 58,
                          alignment: Alignment.center,
                          child: Text("Gider ekle"),
                        ),
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: const Color(0xFFD1C4E9), // Açık mor
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 65,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        gelirListesi.isNotEmpty
                            ? "SON GELİR:  ${gelirListesi.last['gelir_baslik']} | ${gelirListesi.last['gelir_miktar']}₺ | ${gelirListesi.last['gelir_aciklama']}"
                            : "SON GELİR: Veri yok",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Card(
              color: const Color(0xFFD1C4E9),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 65,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        giderListesi.isNotEmpty
                            ? "SON GİDER:  ${giderListesi.last['gider_baslik']} | ${giderListesi.last['gider_miktar']}₺ | ${giderListesi.last['gider_aciklama']}"
                            : "SON GİDER: Veri yok",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Card(
              color: const Color(0xFF9575CD), // Orta ton mor
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 58,
                      alignment: Alignment.center,
                      child: Text(
                        "Bakiye: $bakiye TL",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors
                              .white, // Yazı rengi beyaz olsun ki kontrast iyi olsun
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

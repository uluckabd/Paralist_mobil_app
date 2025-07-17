import 'package:paralist/Veritabanierisim.dart';

class Gelirgiderdao {
  Future<void> gelirSil(int gelirId) async {
    var db = await VeritabaniErisim.veritabanierisim();
    await db.delete('gelirler', where: 'gelir_id = ?', whereArgs: [gelirId]);
  }

  Future<void> giderSil(int giderId) async {
    var db = await VeritabaniErisim.veritabanierisim();
    await db.delete('giderler', where: 'gider_id = ?', whereArgs: [giderId]);
  }

  Future<List<Map<String, dynamic>>> tumGelirleriAl() async {
    var db = await VeritabaniErisim.veritabanierisim();
    return await db.rawQuery("SELECT * FROM gelirler");
  }

  Future<List<Map<String, dynamic>>> tumgiderlerial() async {
    var db = await VeritabaniErisim.veritabanierisim();
    return await db.rawQuery("SELECT * FROM giderler");
  }

  Future<void> gelirekle(
    String gelir_baslik,
    int gelir_miktar,
    String gelir_aciklama,
  ) async {
    var db = await VeritabaniErisim.veritabanierisim();
    await db.rawInsert(
      "INSERT INTO gelirler(gelir_baslik, gelir_miktar, gelir_aciklama) VALUES(?, ?, ?)",
      [gelir_baslik, gelir_miktar, gelir_aciklama],
    );
  }

  Future<void> giderekle(
    String gider_baslik,
    int gider_miktar,
    String gider_aciklama,
  ) async {
    var db = await VeritabaniErisim.veritabanierisim();
    await db.rawInsert(
      "INSERT INTO giderler(gider_baslik, gider_miktar, gider_aciklama) VALUES(?, ?, ?)",
      [gider_baslik, gider_miktar, gider_aciklama],
    );
  }
}

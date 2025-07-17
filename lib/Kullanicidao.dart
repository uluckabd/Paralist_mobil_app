import 'package:paralist/Veritabanierisim.dart';

class Kullanicidao {
  Future<void> kullaniciekle(String kullaniciadi, String sifre) async {
    var db = await VeritabaniErisim.veritabanierisim();
    await db.rawInsert(
      "INSERT INTO giriskayit(uye_kullaniciadi,uye_sifre) VALUES(?,?)",

      [kullaniciadi, sifre],
    );
  }

  Future<bool> kullaniciVarMi(String kullaniciadi, String sifre) async {
    var db = await VeritabaniErisim.veritabanierisim();
    List<Map<String, dynamic>> sonuc = await db.rawQuery(
      "SELECT * FROM giriskayit WHERE uye_kullaniciadi = ? AND uye_sifre = ?",
      [kullaniciadi, sifre],
    );
    return sonuc.isNotEmpty;
  }
}

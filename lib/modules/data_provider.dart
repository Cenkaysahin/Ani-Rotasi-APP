import 'location_service.dart';

class DataProvider {
  static List<String> _cities = ['Adana','Istanbul', 'Ankara', 'Izmir','Bursa','Konya']; // Örnek şehirler
  static Map<String, List<String>> _districts = {
    'Istanbul': ['Fatih', 'Beyoğlu', 'Üsküdar'],
    'Ankara': ['Ulus', 'Altındağ', 'Çankaya','Keçiören','Mamak'],
    'Izmir': ['Konak', 'Bornova', 'Çiğli','Balçova','Karşıyaka'],
    'Adana': ['Seyhan', 'Yüreğir', 'Çukurova'],
    'Bursa': ['Yıldırım', 'Osmangazi', 'Kestel'],
    'Konya': ['Karatay', 'Selçuklu', 'Meram'],
  };

  static List<String> getCities() {
    return _cities;
  }

  static List<String> getDistricts(String city) {
    return _districts[city] ?? [];
  }

  static Future<List<Map<String, dynamic>>> getCards(String city, String district) async {

    List<Map<String, dynamic>> places = await findNearestPlaces(city, district);


    places = places.map((place) {
      place['photo_url'] = getPhotoAssetPath(place['name']);
      return place;
    }).toList();

    return places;
  }

  static String getPhotoAssetPath(String name) {

    Map<String, String> photoAssets = {
      'Adana Cinema Museum': 'assets/adana_cinema_museum.png',
      'Stone Bridge': 'assets/stone_bridge.png',
      'Great Clock Tower': 'assets/great_clock_tower.png',
      'Seyhan Merkez Park': 'assets/seyhan_merkez_park.png',
      'Ataturk Park': 'assets/ataturk_park.png',
      'Natural Park': 'assets/natural_park.png',
      'Sabanci Central Mosque': 'assets/sabanci_central_mosque.png',
      'Tarihi Kazancilar Çarşısı': 'assets/tarihi_kazancilar_carsi.png',
      'Ziyapaşa Parkı': 'assets/ziyapasa_park.png',
      'Ataturk Scientific & Cultural Museum': 'assets/ataturk_scientific_cultural_museum.png',
      'Adana Etnografya Müzesi': 'assets/adana_etnografya_muzesi.png',
      'Museum of Anatolian Civilizations': 'assets/museum_of_anatolian_civilizations.png',
      'Anıtkabir': 'assets/anitkabir.png',
      'Haci Bayram Mosque': 'assets/haci_bayram_mosque.png',
      'Ankara Castle': 'assets/ankara_castle.png',
      'Kuğulu Park': 'assets/kugulu_park.png',
      'Keçiören Falls': 'assets/kecioren_falls.png',
      'Ulucanlar Prison Museum': 'assets/ulucanlar_prison_museum.png',
      'Masal Adası': 'assets/masal_adasi.png',
      'Ataturk Statue': 'assets/ataturk_statue.png',
      'Republic Museum (The Second Parliament Building)': 'assets/republic_museum.png',
      '50th Year Park': 'assets/50th_year_park.png',
      'Botanical Park': 'assets/botanical_park.png',
      'Hamamönü old Ankara Houses': 'assets/hamamonu_old_ankara_houses.png',
      'Column of Julian': 'assets/column_of_julian.png',
      'Independence Park': 'assets/independence_park.png',
      'Erimtan Archaeology and Art Museum': 'assets/erimtan_archaeology_and_art_museum.png',
      'Esertepe Park': 'assets/esertepe_park.png',
      'METU Forest': 'assets/metu_forest.png',
      'Ankara Evi Park': 'assets/ankara_evi_park.png',
      'Hamamarkası Public Square': 'assets/hamamarkasi_public_square.png',
      'Green Tomb': 'assets/green_tomb.png',
      'Koza Han': 'assets/koza_han.png',
      'Tomb of Osman Gazi': 'assets/tomb_of_osman_gazi.png',
      'Muradiye Complex': 'assets/muradiye_complex.png',
      'Tophane Clock Tower': 'assets/tophane_clock_tower.png',
      'Bursa City Museum': 'assets/bursa_city_museum.png',
      'Bursa Grand Mosque': 'assets/bursa_grand_mosque.png',
      'Sultan\'s Mansion Museum': 'assets/sultans_mansion_museum.png',
      'İnkaya Historical Plane Tree': 'assets/inkaya_historical_plane_tree.png',
      'Reşat Oyal Culture Park': 'assets/resat_oyal_culture_park.png',
      'Kaplıkaya Growth Center': 'assets/kaplikaya_growth_center.png',
      'Bursa Archaeological Museum': 'assets/bursa_archaeological_museum.png',
      'Karagoz Museum': 'assets/karagoz_museum.png',
      'Heykel': 'assets/heykel.png',
      'Han Brass': 'assets/han_brass.png',
      'Kestel Castle': 'assets/kestel_castle.png',
      'Küreklidere Falls': 'assets/kureklidere_falls.png',
      'Cumalikizik Village (UNESCO)': 'assets/cumalikizik_village.png',
      'Orhan Gazi Mosque': 'assets/orhan_gazi_mosque.png',
      'Viewpoint': 'assets/viewpoint.png',
      'Temenyeri Park': 'assets/temenyeri_park.png',
      'Inkaya historical plane tree 610 tree old': 'assets/inkaya_historical_plane_tree_610.png',
      'Bursa': 'assets/bursa.png',
      'Topkapi Palace Museum': 'assets/topkapi_palace_museum.png',
      'Basilica Cistern': 'assets/basilica_cistern.png',
      'Dolmabahçe Palace': 'assets/dolmabahce_palace.png',
      'The Blue Mosque': 'assets/the_blue_mosque.png',
      'Hagia Sophia Grand Mosque': 'assets/hagia_sophia_grand_mosque.png',
      'Galata Tower': 'assets/galata_tower.png',
      'Dolmabahçe Palace': 'assets/dolmabahce_palace.png',
      'Grand Bazaar': 'assets/grand_bazaar.png',
      'Beylerbeyi Palace': 'assets/beylerbeyi_palace.png',
      'Istanbul Archaeological Museums': 'assets/istanbul_archaeological_museums.png',
      'Sultanahmet Square': 'assets/sultanahmet_square.png',
      'Egyptian Bazaar': 'assets/egyptian_bazaar.png',
      'Suleymaniye Mosque': 'assets/suleymaniye_mosque.png',
      'Gülhane Park': 'assets/gulhane_park.png',
      'Kariye Mosque': 'assets/kariye_mosque.png',
      'Bosfor İstanbul': 'assets/bosfor_istanbul.png',
      'Galata Bridge': 'assets/galata_bridge.png',
      'Dolmabahçe Clock Tower': 'assets/dolmabahce_clock_tower.png',
      'Beyazit Square': 'assets/beyazit_square.png',
      'Cistern of Theodosius': 'assets/cistern_of_theodosius.png',
      'İzmir Historical Elevator Building': 'assets/izmir_historical_elevator_building.png',
      'Izmir Wildlife Park': 'assets/izmir_wildlife_park.png',
      'Clock Tower of İzmir': 'assets/clock_tower_of_izmir.png',
      'İzmir Atatürk Anıtı': 'assets/izmir_ataturk_aniti.png',
      'İnciraltı Kent Ormanı': 'assets/inciralti_kent_ormani.png',
      'Arkas Art Center': 'assets/arkas_art_center.png',
      'Izmir Archaeological and Ethnography Museum': 'assets/izmir_archaeological_and_ethnography_museum.png',
      'Kemeraltı Bazaar': 'assets/kemeralti_bazaar.png',
      'Ataturk Konak Square': 'assets/ataturk_konak_square.png',
      'Agora Ören Yeri': 'assets/agora_oren_yeri.png',
      'Agora of Smyrna': 'assets/agora_of_smyrna.png',
      'Varyant': 'assets/varyant.png',
      'İZULAŞ A.Ş. İZMİR BALÇOVA TELEFERİK': 'assets/izulas_izmir_balcova_teleferik.png',
      'Universal Children\'s Museum and Theme Park': 'assets/universal_childrens_museum_and_theme_park.png',
      'Güzelyali Park': 'assets/guzelyali_park.png',
      'Izmir Cruise Pirs': 'assets/izmir_cruise_pirs.png',
      'Ataturk Museum': 'assets/ataturk_museum.png',
      'Arkas Marine Historical Center': 'assets/arkas_marine_historical_center.png',
      'Peace Steps': 'assets/peace_steps.png',
      'History & Arts Museum': 'assets/history_arts_museum.png',
      'Mevlana Museum': 'assets/mevlana_museum.png',
      'Konya Tropical Butterfly Garden': 'assets/konya_tropical_butterfly_garden.png',
      'Azizia Mosque': 'assets/azizia_mosque.png',
      'Stone Works Museum of Fine Minaret': 'assets/stone_works_museum_of_fine_minaret.png',
      'Around the World in 80 Thousand Park': 'assets/around_the_world_in_80_thousand_park.png',
      'Konya Science Center': 'assets/konya_science_center.png',
      'Selimiye Mosque': 'assets/selimiye_mosque.png',
      'Culture Park': 'assets/culture_park.png',
      'Mevlana Meydanı': 'assets/mevlana_meydani.png',
      'Karatay Belediyesi Hayvanat Bahçesi': 'assets/karatay_belediyesi_hayvanat_bahcesi.png',
      'Kyoto Japanese Park': 'assets/kyoto_japanese_park.png',
      'Karatay Madrasa': 'assets/karatay_madrasa.png',
      'Karatay Şehir Parkı': 'assets/karatay_sehir_parki.png',
      'Akyokus Park': 'assets/akyokus_park.png',
      'Shams of Tabriz Mosque and Tomb': 'assets/shams_of_tabriz_mosque_and_tomb.png',
      'Sahip Ata Museum': 'assets/sahip_ata_museum.png',
      'KONYA MERAM BAĞLARI': 'assets/konya_meram_baglari.png',
      'Karaaslan Hadimi Park': 'assets/karaaslan_hadimi_park.png',
      'Gedavet Park': 'assets/gedavet_park.png',
      'Sırçalı Medrese': 'assets/sircal_medrese.png',
      // Diğer yerler için benzer şekilde asset yolları ekleyebilirsiniz
    };

    return photoAssets[name] ?? 'assets/placeholder.png'; // Varsayılan görsel
  }
}
import os
import requests
from bs4 import BeautifulSoup

# Mekan isimleri ve dosya adları
locations = {
    'Adana Cinema Museum': 'adana_cinema_museum.png',
    'Stone Bridge': 'stone_bridge.png',
    'Great Clock Tower': 'great_clock_tower.png',
    'Seyhan Merkez Park': 'seyhan_merkez_park.png',
    'Ataturk Park': 'ataturk_park.png',
    'Natural Park': 'natural_park.png',
    'Sabanci Central Mosque': 'sabanci_central_mosque.png',
    'Tarihi Kazancilar Çarşısı': 'tarihi_kazancilar_carsi.png',
    'Ziyapaşa Parkı': 'ziyapasa_park.png',
    'Ataturk Scientific & Cultural Museum': 'ataturk_scientific_cultural_museum.png',
    'Adana Etnografya Müzesi': 'adana_etnografya_muzesi.png',
    'Museum of Anatolian Civilizations': 'museum_of_anatolian_civilizations.png',
    'Anıtkabir': 'anitkabir.png',
    'Haci Bayram Mosque': 'haci_bayram_mosque.png',
    'Ankara Castle': 'ankara_castle.png',
    'Kuğulu Park': 'kugulu_park.png',
    'Keçiören Falls': 'kecioren_falls.png',
    'Ulucanlar Prison Museum': 'ulucanlar_prison_museum.png',
    'Masal Adası': 'masal_adasi.png',
    'Ataturk Statue': 'ataturk_statue.png',
    'Republic Museum (The Second Parliament Building)': 'republic_museum.png',
    '50th Year Park': '50th_year_park.png',
    'Botanical Park': 'botanical_park.png',
    'Hamamönü old Ankara Houses': 'hamamonu_old_ankara_houses.png',
    'Column of Julian': 'column_of_julian.png',
    'Independence Park': 'independence_park.png',
    'Erimtan Archaeology and Art Museum': 'erimtan_archaeology_and_art_museum.png',
    'Esertepe Park': 'esertepe_park.png',
    'METU Forest': 'metu_forest.png',
    'Ankara Evi Park': 'ankara_evi_park.png',
    'Hamamarkası Public Square': 'hamamarkasi_public_square.png',
    'Green Tomb': 'green_tomb.png',
    'Koza Han': 'koza_han.png',
    'Tomb of Osman Gazi': 'tomb_of_osman_gazi.png',
    'Muradiye Complex': 'muradiye_complex.png',
    'Tophane Clock Tower': 'tophane_clock_tower.png',
    'Bursa City Museum': 'bursa_city_museum.png',
    'Bursa Grand Mosque': 'bursa_grand_mosque.png',
    'Sultan\'s Mansion Museum': 'sultans_mansion_museum.png',
    'İnkaya Historical Plane Tree': 'inkaya_historical_plane_tree.png',
    'Reşat Oyal Culture Park': 'resat_oyal_culture_park.png',
    'Kaplıkaya Growth Center': 'kaplikaya_growth_center.png',
    'Bursa Archaeological Museum': 'bursa_archaeological_museum.png',
    'Karagoz Museum': 'karagoz_museum.png',
    'Heykel': 'heykel.png',
    'Han Brass': 'han_brass.png',
    'Kestel Castle': 'kestel_castle.png',
    'Küreklidere Falls': 'kureklidere_falls.png',
    'Cumalikizik Village (UNESCO)': 'cumalikizik_village.png',
    'Orhan Gazi Mosque': 'orhan_gazi_mosque.png',
    'Viewpoint': 'viewpoint.png',
    'Temenyeri Park': 'temenyeri_park.png',
    'Inkaya historical plane tree 610 tree old': 'inkaya_historical_plane_tree_610.png',
    'Bursa': 'bursa.png',
    'Topkapi Palace Museum': 'topkapi_palace_museum.png',
    'Basilica Cistern': 'basilica_cistern.png',
    'Dolmabahçe Palace': 'dolmabahce_palace.png',
    'The Blue Mosque': 'the_blue_mosque.png',
    'Hagia Sophia Grand Mosque': 'hagia_sophia_grand_mosque.png',
    'Galata Tower': 'galata_tower.png',
    'Grand Bazaar': 'grand_bazaar.png',
    'Beylerbeyi Palace': 'beylerbeyi_palace.png',
    'Istanbul Archaeological Museums': 'istanbul_archaeological_museums.png',
    'Sultanahmet Square': 'sultanahmet_square.png',
    'Egyptian Bazaar': 'egyptian_bazaar.png',
    'Suleymaniye Mosque': 'suleymaniye_mosque.png',
    'Gülhane Park': 'gulhane_park.png',
    'Kariye Mosque': 'kariye_mosque.png',
    'Bosfor İstanbul': 'bosfor_istanbul.png',
    'Galata Bridge': 'galata_bridge.png',
    'Dolmabahçe Clock Tower': 'dolmabahce_clock_tower.png',
    'Beyazit Square': 'beyazit_square.png',
    'Cistern of Theodosius': 'cistern_of_theodosius.png',
    'İzmir Historical Elevator Building': 'izmir_historical_elevator_building.png',
    'Izmir Wildlife Park': 'izmir_wildlife_park.png',
    'Clock Tower of İzmir': 'clock_tower_of_izmir.png',
    'İzmir Atatürk Anıtı': 'izmir_ataturk_aniti.png',
    'İnciraltı Kent Ormanı': 'inciralti_kent_ormani.png',
    'Arkas Art Center': 'arkas_art_center.png',
    'Izmir Archaeological and Ethnography Museum': 'izmir_archaeological_and_ethnography_museum.png',
    'Kemeraltı Bazaar': 'kemeralti_bazaar.png',
    'Ataturk Konak Square': 'ataturk_konak_square.png',
    'Agora Ören Yeri': 'agora_oren_yeri.png',
    'Agora of Smyrna': 'agora_of_smyrna.png',
    'Varyant': 'varyant.png',
    'İZULAŞ A.Ş. İZMİR BALÇOVA TELEFERİK': 'izulas_izmir_balcova_teleferik.png',
    'Universal Children\'s Museum and Theme Park': 'universal_childrens_museum_and_theme_park.png',
    'Güzelyali Park': 'guzelyali_park.png',
    'Izmir Cruise Pirs': 'izmir_cruise_pirs.png',
    'Ataturk Museum': 'ataturk_museum.png',
    'Arkas Marine Historical Center': 'arkas_marine_historical_center.png',
    'Peace Steps': 'peace_steps.png',
    'History & Arts Museum': 'history_arts_museum.png',
    'Mevlana Museum': 'mevlana_museum.png',
    'Konya Tropical Butterfly Garden': 'konya_tropical_butterfly_garden.png',
    'Azizia Mosque': 'azizia_mosque.png',
    'Stone Works Museum of Fine Minaret': 'stone_works_museum_of_fine_minaret.png',
    'Around the World in 80 Thousand Park': 'around_the_world_in_80_thousand_park.png',
    'Konya Science Center': 'konya_science_center.png',
    'Selimiye Mosque': 'selimiye_mosque.png',
    'Culture Park': 'culture_park.png',
    'Mevlana Meydanı': 'mevlana_meydani.png',
    'Karatay Belediyesi Hayvanat Bahçesi': 'karatay_belediyesi_hayvanat_bahcesi.png',
    'Kyoto Japanese Park': 'kyoto_japanese_park.png',
    'Karatay Madrasa': 'karatay_madrasa.png',
    'Karatay Şehir Parkı': 'karatay_sehir_parki.png',
    'Akyokus Park': 'akyokus_park.png',
    'Shams of Tabriz Mosque and Tomb': 'shams_of_tabriz_mosque_and_tomb.png',
    'Sahip Ata Museum': 'sahip_ata_museum.png',
    'KONYA MERAM BAĞLARI': 'konya_meram_baglari.png',
    'Karaaslan Hadimi Park': 'karaaslan_hadimi_park.png',
    'Gedavet Park': 'gedavet_park.png',
    'Sırçalı Medrese': 'sircal_medrese.png',
    'Placeholder': 'placeholder.png'
}

# Klasör oluşturma
assets_dir = 'assets'
if not os.path.exists(assets_dir):
    os.makedirs(assets_dir)

# Google Görseller'den fotoğraf URL'lerini bulma ve indirme fonksiyonu
def fetch_photo_url(query):
    url = f"https://www.google.com/search?hl=en&tbm=isch&q={query}"
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
    }
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.text, "html.parser")
    images = soup.find_all("img")
    if images:
        return images[1]["src"]  # İlk görsel, Google logosu olabilir, bu yüzden ikinci görseli alıyoruz.
    return None

# Fotoğrafları indirip kaydetme
for name, filename in locations.items():
    print(f"{name} için fotoğraf aranıyor...")
    photo_url = fetch_photo_url(name + " site:tr")
    if photo_url:
        image_response = requests.get(photo_url)
        if image_response.status_code == 200:
            with open(os.path.join(assets_dir, filename), 'wb') as f:
                f.write(image_response.content)
            print(f"{name} için fotoğraf kaydedildi: {filename}")
        else:
            print(f"{name} için fotoğraf indirilemedi: {photo_url}")
    else:
        print(f"{name} için fotoğraf bulunamadı.")

print("Tüm fotoğraflar indirildi ve kaydedildi.")

class DataProvider {
  static List<String> getCities() {
    return ['İstanbul', 'Ankara', 'İzmir'];
  }

  static List<String> getDistricts(String city) {
    return ['Mahalle 1', 'Mahalle 2', 'Mahalle 3'];
  }

  static List<String> getCards(String city, String district) {
    return ['Kart 1', 'Kart 2', 'Kart 3', 'Kart 4', 'Kart 5'];
  }
}

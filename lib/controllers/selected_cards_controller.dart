import 'package:get/get.dart';

class SelectedCardsController extends GetxController {
  // Seçilen kartları saklayacak bir liste
  var selectedCards = <Map<String, dynamic>>[].obs;

  // Listeye yeni kart ekleyen bir yöntem
  void addCard(Map<String, dynamic> card) {
    selectedCards.add(card);
  }

  // Listeyi temizleyen bir yöntem
  void clearCards() {
    selectedCards.clear();
  }
}

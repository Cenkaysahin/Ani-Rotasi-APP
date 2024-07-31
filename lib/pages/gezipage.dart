import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/selected_cards_controller.dart';
import 'card_detail_page.dart'; // Detay sayfasını ekleyin

class Gezipage extends StatelessWidget {
  Gezipage({super.key});

  final SelectedCardsController _selectedCardsController = Get.find<SelectedCardsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd6c6a6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff34322c),
        title: Text(
          'Seçtikleriniz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (_selectedCardsController.selectedCards.isEmpty) {
          return Center(
            child: Text('Seçilen kart yok'),
          );
        }
        return ListView.builder(
          itemCount: _selectedCardsController.selectedCards.length,
          itemBuilder: (context, index) {
            final card = _selectedCardsController.selectedCards[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailPage(card: card),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                        image: DecorationImage(
                          image: AssetImage(card['photo_url']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            card['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '${card['address']}',
                            style: TextStyle(color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Rating: ${card['rating']} - User Ratings: ${card['user_ratings_total']}',
                            style: TextStyle(color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

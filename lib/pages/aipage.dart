import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oua_bootcamp/Pages/loginpage.dart';
import 'package:tcard/tcard.dart';
import '../modules/data_provider.dart';
import 'package:get/get.dart';
import '../controllers/selected_cards_controller.dart'; // SelectedCardsController'ı ekleyin

class Aipage extends StatefulWidget {
  const Aipage({super.key});

  @override
  State<Aipage> createState() => _AipageState();
}

class _AipageState extends State<Aipage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCity;
  String? _selectedDistrict;
  List<Map<String, dynamic>> _filteredCards = [];
  bool _showFilters = true;

  final SelectedCardsController _selectedCardsController =
      Get.find<SelectedCardsController>();

  Future<void> _fetchPlaces() async {
    if (_selectedCity != null && _selectedDistrict != null) {
      final places =
          await DataProvider.getCards(_selectedCity!, _selectedDistrict!);
      setState(() {
        _filteredCards = places;
        _showFilters = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd6c6a6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff34322c),
        automaticallyImplyLeading: false,
        title: const Text(
          'ANI ROTASI',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // Oturumu kapat
              await FirebaseAuth.instance.signOut();

              // Navigation geçmişinin tamamını temizle ve Login sayfasına yönlendir
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            color: Colors.white70,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Şehir'),
                      value: _selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity = newValue;
                          _selectedDistrict = null;
                        });
                      },
                      items: DataProvider.getCities()
                          .map<DropdownMenuItem<String>>((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'İlçe'),
                      value: _selectedDistrict,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue;
                        });
                      },
                      items: (_selectedCity != null
                              ? DataProvider.getDistricts(_selectedCity!)
                              : [])
                          .map<DropdownMenuItem<String>>((district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _fetchPlaces();
                        }
                      },
                      child: Text('Filtrele'),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: _filteredCards.isNotEmpty
                ? TCard(
                    cards: _filteredCards.map((place) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 35.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 300.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                                image: DecorationImage(
                                  image: AssetImage(place['photo_url']),
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
                                    place['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    '${place['address']}',
                                    style: TextStyle(color: Colors.grey[600]),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Rating: ${place['rating']} - User Ratings: ${place['user_ratings_total']}',
                                    style: TextStyle(color: Colors.grey[600]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onForward: (index, info) {
                      if (info.direction == SwipDirection.Right) {
                        _selectedCardsController.addCard(_filteredCards[index]);
                        print("Kart $index seçildi");
                      } else if (info.direction == SwipDirection.Left) {
                        print("Kart $index reddedildi");
                      }
                    },
                    onEnd: () {
                      print("Kartlar bitti");
                    },
                  )
                : Center(
                    child: Text('Gösterilecek kart yok'),
                  ),
          ),
        ],
      ),
    );
  }
}

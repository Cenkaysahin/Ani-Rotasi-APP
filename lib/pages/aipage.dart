import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:oua_bootcamp/modules/data_provider.dart';

class Aipage extends StatefulWidget {
  const Aipage({super.key});

  @override
  State<Aipage> createState() => _AipageState();
}

class _AipageState extends State<Aipage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCity;
  String? _selectedDistrict;
  List<String> _filteredCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         automaticallyImplyLeading: false,
        title: Text('Ani Rotası'),
      ),
      body: Column(
        children: [
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
                        _selectedDistrict = null; // Şehir değiştiğinde ilçeyi sıfırla
                      });
                    },
                    items: DataProvider.getCities().map<DropdownMenuItem<String>>((city) {
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
                        setState(() {
                          if (_selectedCity != null && _selectedDistrict != null) {
                            _filteredCards = DataProvider.getCards(_selectedCity!, _selectedDistrict!);
                          }
                        });
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
              cards: _filteredCards.map((cardText) {
                return Card(
                  child: Center(
                    child: Text(
                      cardText,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                );
              }).toList(),
              onForward: (index, info) {
                if (info.direction == SwipDirection.Right) {
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

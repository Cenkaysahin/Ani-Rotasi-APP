import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'intax_page.dart'; // IntaxPage'i ekleyin

class CardDetailPage extends StatelessWidget {
  final Map<String, dynamic> card;

  CardDetailPage({required this.card, super.key});

  Future<void> _launchMaps() async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(card['address'])}'
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd6c6a6),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          card['name'],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff34322c),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(card['photo_url']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  card['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  card['address'],
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Rating: ${card['rating']} - User Ratings: ${card['user_ratings_total']}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _launchMaps,
                  child: Text('Konum Aç'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IntaxPage()),
                    );
                  },
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  label: Text('Konumdan Anı Bırak'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

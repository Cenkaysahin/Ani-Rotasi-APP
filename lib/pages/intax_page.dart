import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class IntaxPage extends StatefulWidget {
  const IntaxPage({super.key});

  @override
  _IntaxPageState createState() => _IntaxPageState();
}

class _IntaxPageState extends State<IntaxPage> {
  File? _image;
  final _textController = TextEditingController();
  late String _dateTime;
  late String _location;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _location = 'Konum bilgisi yok';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd – kk:mm');
    setState(() {
      _dateTime = formatter.format(now);
    });
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        backgroundColor: Color(0xffd6c6a6),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Anı Bırak',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff34322c),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white, width: 0.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 345.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[300]!, width: 2.0),
                  ),
                  child: _image == null
                      ? Center(
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, size: 50.0, color: Colors.grey),
                      onPressed: _pickImage,
                    ),
                  )
                      : Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.black.withOpacity(0.6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _dateTime,
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                _location,
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Yaşadığınız anıları buraya yazın...',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Bu butona tıklanınca yapılacak işlemler buraya eklenebilir
                  },
                  child: Text('Kaydet'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        ),
      ),
    );
  }
}

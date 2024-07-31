import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:oua_bootcamp/Pages/loginpage.dart';
import 'package:oua_bootcamp/controllers/selected_cards_controller.dart'; // Doğru dosya yolunu kullanın

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // GetX bağımlılık yönetim sistemine SelectedCardsController'ı kaydedin
  Get.put(SelectedCardsController());

  // Firebase'i başlat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: LoginPage(), // İlk sayfa olarak LoginPage'i belirleyin
      ),
    );
  }
}

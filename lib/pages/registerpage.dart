import 'package:flutter/material.dart';
import 'package:oua_bootcamp/Pages/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = "";
  bool sifre_gozukme = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/arkaplan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0, bottom: 40),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(top: 20, bottom: 40, right: 30, left: 30),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'E-mail',
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 40, right: 30, left: 30),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: sifre_gozukme,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Şifre',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                sifre_gozukme = !sifre_gozukme;
                              });
                            },
                            icon: Icon(
                              sifre_gozukme ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                            ),
                            color: Color(0xff6a5b32),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 40, right: 30, left: 30),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: sifre_gozukme,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tekrar Şifrenizi Giriniz',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                sifre_gozukme = !sifre_gozukme;
                              });
                            },
                            icon: Icon(
                              sifre_gozukme ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                            ),
                            color: Color(0xff6a5b32),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 70, bottom: 40, right: 30, left: 30),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                          ),
                          color: Color(0xff6a5b32),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              offset: Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Kayıt ol",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Geri dönüş
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

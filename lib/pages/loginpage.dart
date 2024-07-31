import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oua_bootcamp/pages/registerpage.dart';
import 'package:oua_bootcamp/modules/navigationmenu.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 40),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 3,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 20, bottom: 10, right: 30, left: 30),
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
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
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

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Navigationmenu()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
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
                        "Giriş Yap",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 40, left: 30, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Yeni Kullanıcı? ÜYE OL",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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

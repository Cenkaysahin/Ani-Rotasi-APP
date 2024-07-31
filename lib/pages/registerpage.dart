import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oua_bootcamp/modules/navigationmenu.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = "";
  bool sifre_gozukme = false;

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _onRegisterTap() async {
      final email = _emailInputController.text;
      final psw = _passwordInputController.text;
      final pswRepeat = _passwordRepeatController.text;

      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Lütfen gerçek bir e-posta adresi sağlayınız!"),
          ),
        );

        return;
      }

      if (psw.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Şifre en az 8 karakterden oluşmalıdır!"),
          ),
        );

        return;
      }

      if (psw != pswRepeat) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Lütfen parolanızı doğrulayın!"),
          ),
        );

        return;
      }

      // Yeni kullanıcı oluştur
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: psw,
        );

        if (user.credential != null) {
          // Auth successful
          // Navigation geçmişinin tamamını temizle ve Login sayfasına yönlendir
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const Navigationmenu()),
            (Route<dynamic> route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        // Parola güçsüz
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Lütfen daha güçlü bir parola oluşturun!"),
            ),
          );
        }

        // Zaten e-posta mevcut
        else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Bu e-posta adresine sahip bir kullanıcı zaten mevcut!"),
            ),
          );
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
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
                      margin: const EdgeInsets.only(top: 0, bottom: 40),
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
                        color: const Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 40, right: 30, left: 30),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: TextField(
                        controller: _emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
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
                        color: const Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 40, right: 30, left: 30),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passwordInputController,
                              obscureText: sifre_gozukme,
                              decoration: const InputDecoration(
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
                              sifre_gozukme
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                            ),
                            color: const Color(0xff6a5b32),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        color: const Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 40, right: 30, left: 30),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _passwordRepeatController,
                              obscureText: sifre_gozukme,
                              decoration: const InputDecoration(
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
                              sifre_gozukme
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                            ),
                            color: const Color(0xff6a5b32),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: _onRegisterTap,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 70, bottom: 40, right: 30, left: 30),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                          ),
                          color: const Color(0xff6a5b32),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
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

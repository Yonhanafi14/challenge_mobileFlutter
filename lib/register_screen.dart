import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:login_form_challenge/login_screen.dart';
import 'package:login_form_challenge/res_register.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegExp validatonFull = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double kekuatanPassword = 0;
  TextEditingController password = TextEditingController();

  RegExp huruf = RegExp(r"(?=.*[a-z])(?=.*[A-Z])");
  RegExp angka = RegExp(r"[0-9]");
  bool minimal8huruf = false;
  bool hurufBesarKecil = false;
  bool minimal1Angka = false;

  bool validatePassword(String pass) {
    if (password.text.isEmpty) {
      setState(() {
        kekuatanPassword = 0;
      });
    } else if (password.text.length < 8) {
      setState(() {
        kekuatanPassword = 1 / 4;
      });
    } else if (password.text.length < 10) {
      setState(() {
        kekuatanPassword = 2 / 4;
      });
    } else if (password.text.length < 12) {
      setState(() {
        kekuatanPassword = 3 / 4;
      });
    } else if (validatonFull.hasMatch(password.text)) {
      setState(() {
        kekuatanPassword = 4 / 4;
      });
      return true;
    }
    return false;
  }

  void validateRequirement() {
//password minimal 8 karakter

    if (password.text.length >= 8) {
      minimal8huruf = true;
    } else {
      minimal8huruf = false;
    }

    // huruf besar kecil
    if (password.text.contains(huruf)) {
      hurufBesarKecil = true;
    } else {
      hurufBesarKecil = false;
    }
    //
    if (password.text.contains(angka)) {
      minimal1Angka = true;
    } else {
      minimal1Angka = false;
    }
  }

  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isLoading = false;

  Future<ResRegister?> registerUsers() async {
    try {
      setState(() {
        isLoading = true;
      });

      var res = await http.post(
          Uri.parse(
              "http://192.168.88.28/coding_register/register.php"),
          body: {
            "name": nama.text,
            "email": email.text,
            "password": password.text
          });
      ResRegister data = resRegisterFromJson(res.body);
      if (data.value == 1) {
        isLoading = false;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message ?? "")));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message ?? "")));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: SizedBox(
                  height: 150,
                  child: Text(
                    "Register \nScreen",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nama,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Name"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Email"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Password"),
                        onChanged: (value) {
                          validatePassword(value);
                          validateRequirement();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(
                          value: kekuatanPassword,
                          minHeight: 10,
                          backgroundColor: Colors.grey,
                          color: kekuatanPassword <= 1 / 4
                              ? Colors.red
                              : kekuatanPassword == 2 / 4
                                  ? Colors.yellow
                                  : kekuatanPassword == 3 / 4
                                      ? Colors.blue
                                      : kekuatanPassword == 4 / 4
                                          ? Colors.green
                                          : null),
                      Row(
                        children: [
                          minimal8huruf
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          Text(
                            "Panjang Minimal 8 Karakter",
                            style: TextStyle(
                                color:
                                    minimal8huruf ? Colors.green : Colors.red),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          hurufBesarKecil
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          Text(
                            "Huruf besar dan kecil",
                            style: TextStyle(
                                color: hurufBesarKecil
                                    ? Colors.green
                                    : Colors.red),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          minimal1Angka
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          Text(
                            "Minimal 1 Angka",
                            style: TextStyle(
                                color:
                                    minimal1Angka ? Colors.green : Colors.red),
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed:
                              minimal8huruf && hurufBesarKecil && minimal1Angka
                                  ? () {
                                      registerUsers();
                                    }
                                  : null,
                          child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text("Register")))),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Sudah mempunyai akun? "),
                            Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

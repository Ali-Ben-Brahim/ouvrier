import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:provider/provider.dart';

import '../services/user_service.dart';
import 'forget_password.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  dynamic user;
  bool _isconnected = false;
  dynamic _data;
  String qrData = '';

  Future _scan() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              "#000000", "cancel", true, ScanMode.BARCODE)
          .then((value) {
        setState(() {
          qrData = value.substring(7);
        });
        Provider.of<Auth>(context, listen: false).loginqr(qrData, context);
      });
    } catch (e) {
      print('ADMIN ERROR : \n $e');
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = 'ouvrier1.reschool@gmail.com';
    _passwordController.text = 'ouvrier1';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF196f3d),
            title: const Text("RE: ECOLOGIE",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 30,
                ))),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    height: 150,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(30),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("Image/logo-recyclage.png"),
                    )),
                  ),
                  Container(
                    width: 295,
                    height: 48,
                    margin: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter valid email ' : null,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                                color: Color(0xFF196f3d), width: 2.0)),
                        hintText: 'Exemple@mail.com',
                        hintStyle: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 295,
                    height: 48,
                    margin: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) => value!.isEmpty
                          ? 'Please enter valid password '
                          : null,
                      obscureText: _isObscure,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                                color: Color(0xFF196f3d), width: 2.0)),
                        hintText: '●●●●●●●',
                        hintStyle: const TextStyle(fontSize: 10.0),
                        suffixIcon: IconButton(
                      icon: Icon(

                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                }),
                      ),
                    ),
                  ),
                  Container(
                    width: 290,
                    margin: const EdgeInsets.only(bottom: 60),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Text(
                        "Mot de passe oublie?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2989E1),
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ForgetPassword()),
                        ));
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map creeds = {
                          'email': _emailController.text.trim(),
                          'mot_de_passe': _passwordController.text.trim(),
                          "device_name": "A30"
                        };
                        Provider.of<Auth>(context, listen: false)
                            .login(creeds, context);
                      }
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF196f3d)),
                        fixedSize:
                            MaterialStateProperty.all(const Size(349, 48)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16))),
                    child: const Text('Connecter'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
                  Container(
                    child: const Text("ou connecter avec QR"),
                  ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        size: 72,
                      ),
                    ),
                    onTap: () {
                      _scan();
                    },
                  ),
                ]),
          ),
        ));
  }
}

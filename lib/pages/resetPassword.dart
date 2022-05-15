import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF196f3d),
          title: Center(
            child: const Text("Changer mot de passe",
                style: TextStyle(
                  fontFamily: "hindi",
                  fontSize: 24,
                )),
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 200,
              ),
              TextFormField(
                obscureText: _isObscure,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  label: Text("Ancien mot de passe"),

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
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
              SizedBox(
                height: 50,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  label: Text("Nouveau mot de passe"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
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
              SizedBox(
                height: 50,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  label: Text("Confirmer votre mot de passe"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0)),
                  hintStyle: const TextStyle(fontSize: 16.0),
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
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),

                onPressed: () {},

                child: Text('Confirmer'), // <-- Text
              ),
            ],
          ),
        )),
      ),
    );
  }
}

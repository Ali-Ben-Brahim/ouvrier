
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/user_service.dart';

class ChangerMotDePasse extends StatefulWidget {
  const ChangerMotDePasse({ Key? key }) : super(key: key);

  @override
  _ChangerMotDePasseState createState() => _ChangerMotDePasseState();
}

class _ChangerMotDePasseState extends State<ChangerMotDePasse> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  dynamic _id;
  password(){
    return TextFormField(
      controller: _passwordController,
      validator: (value)=>value!.isEmpty? 'please enter your password':null,
      decoration:  InputDecoration(
        label: const Text("ancien mot de passe"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 2,
          )
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
      textInputAction: TextInputAction.go,
    );
  }
  newPassword(){
    return TextFormField(
      controller: _newPasswordController,
      validator: (value)=>value!.isEmpty? 'please enter your new password':null,
      decoration:  InputDecoration(
        label: const Text("nouveau mot de passe"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 2,
          )
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
      textInputAction: TextInputAction.go,
    );
  }
  myButton(){
    return Consumer<Auth>(
      builder: (context, auth, child) {
        _id = auth.user.id;
        return Container(
        padding: const EdgeInsets.fromLTRB(0 , 15 , 0 ,0),
        width: double.infinity,
        child:ElevatedButton(
          onPressed:() {
            if(_formKey.currentState!.validate()){
              Map creeds = {'oldPassword' :_passwordController.text , 'newPassword' :_newPasswordController.text};
              Provider.of<Auth>(context , listen: false).updatePassword(_id, creeds, context);

            }
          },
          child: const Text('Changer'),
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                password(),
                const SizedBox(
                    height: 30,
                  ),
                newPassword(),const SizedBox(
                    height: 20,
                  ),
                myButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
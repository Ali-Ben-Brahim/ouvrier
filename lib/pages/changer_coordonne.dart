import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../services/user_service.dart';



class ChangerCoordonne extends StatefulWidget {
  const ChangerCoordonne({ Key? key }) : super(key: key);

  @override
  _ChangercoordCnneState createState() => _ChangercoordCnneState();
}

class _ChangercoordCnneState extends State<ChangerCoordonne> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  dynamic _id ;
  email(){
    return Consumer<Auth>(
      builder: (context, auth, child) {
      _emailController.text = auth.user.email! ;
      _id = auth.user.id;
        return TextFormField(
        controller: _emailController,
        decoration:  InputDecoration(
          label: const Text("email@example.com"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 2,
            )
          ),
          prefixIcon: const Icon(Icons.email),
        ),
        validator: (value)=> value!.isEmpty ? 'Please enter valid email ' : null,
        );
      },
    );
  }
  nom(){
    return Consumer<Auth>(
      builder: (context, auth, child) {
      _nomController.text = auth.user.nom! ;
        return TextFormField(
        controller: _nomController,
        decoration:  InputDecoration(
          label: const Text("nom ...."),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 2,
            )
          ),
          prefixIcon: const Icon(Icons.abc),
        ),
        validator: (value)=> value!.isEmpty ? 'Please enter valid email ' : null,
        );
      },
    );
  }
  prenom(){
    return TextFormField(
        decoration:  InputDecoration(
            label: const Text("Prenom"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 2,
            )
          ),
          prefixIcon: const Icon(Icons.account_circle),
        ),
        textInputAction: TextInputAction.next,
    );
  }
  numero(){
    return TextFormField(
      controller: _numeroController,
      validator: (value) => value!.isEmpty ? 'Please enter valid number ': null,
      decoration:  InputDecoration(
        label: const Text("Numero"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black38,
            width: 2,
          )
        ),
        prefixIcon: const Icon(Icons.phone),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
    );
  }

  myButton(){
    return Container(
        padding: const EdgeInsets.fromLTRB(0 , 15 , 0 ,0),
        width: double.infinity,
        child:ElevatedButton(
          onPressed:() {
            if(_formKey.currentState!.validate()){
              Map data ={
                'email' : _emailController.text ,
                'name' : _nomController.text,
              };
              Provider.of<Auth>(context, listen: false).update(_id, data ,context);
            }
          },
          child: const Text('Changer'),
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child : Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                email(),
                const SizedBox(
                  height: 20,
                ),
                nom(),
                const SizedBox(
                  height: 30,
                ),
                numero(),
                const SizedBox(
                  height: 30,
                ),
                myButton(),
              ],
            ),
          ),
        ),
      )
    );
  }
}
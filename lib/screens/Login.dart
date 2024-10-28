import 'package:flutter/material.dart';
import '../services/AuthService.dart';
import 'Home.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Login COVID-19 Tracker'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: (){
                print('Register');
                Navigator.push(context,
                MaterialPageRoute(builder: (context) =>Register()));
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/covid.png'),
              SizedBox(height: 50.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'email',
                  prefixIcon: Icon(Icons.person), 	
                  fillColor: Colors.white,
                  filled: true
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                validator: (val) => val?.isEmpty ?? true ? 'Enter a valid email':null,
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'password',
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white,
                      filled: true
                  ),
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                validator: (val) => (val?.length ?? 0) < 6 ?
                'Enter a valid password 6+ Chars':null,
                obscureText: true,
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                child: Text('Sign In', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink
                ),
                onPressed: () async {
                  if(_formKey.currentState?.validate() ?? false){
                    print('Ok!!!!!!');
                    print(email);
                    print(password);
                    //dynamic result = await _auth.signInAnom();
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      print('error SignIn!!!');
                      setState(() {
                        error = 'Error SignIn!!!';
                      });
                    }
                    else{
                      print('Sign In Ok !');
                      print(result.uid);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Home()));
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

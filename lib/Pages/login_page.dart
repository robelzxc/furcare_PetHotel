import 'package:final_capstone_furcare/Pages/Utility/splash_screen.dart';
import 'package:final_capstone_furcare/Pages/register.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FurCare Pet Hotel'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/aaaaa.jpg',
                  height: 220,
                  width: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Email', labelText: 'Email'),
                  controller: emailController,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Password', labelText: 'Password'),
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        _login2();
                      },
                      child: Text('Login')),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: 'Don\'t have an Account?',
                          style: TextStyle(
                            color: Colors.white38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _login2() async {
    final String endpoint =
        'http://ec2-54-251-136-115.ap-southeast-1.compute.amazonaws.com:3432/api/auth/v1/login';

    Map<String, String> headers = {
      'nodex-user-origin': 'mobile',
      'nodex-access-key': 'v7pb6wylg4m0xf0kx5zzoved',
      'nodex-secret-key': 'glrvdwi46mq00fg1oqtdx3rg',
      'Content-Type': 'application/json'
    };

    Map<String, String> body = {
      'username': emailController.text,
      'password': passwordController.text,
    };

    String requestBody = convert.jsonEncode(body);
    try {
      http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: requestBody,
      );

      var details = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoadingA()));
        _showMsg(details['message']);
      } else {
        _showMsg(details['message']);
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
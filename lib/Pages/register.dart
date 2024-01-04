import 'package:final_capstone_furcare/Pages/Utility/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var selectValue = '';
  var userData;
  var userToken;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void _getInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var userJson = localStorage.getString('user');
    var user = convert.jsonDecode(userJson.toString());
    setState(() {
      userData = user;
      userToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FurCare Registration'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter your email address';
                      } else {
                        return (!EmailValidator.validate(value!))
                            ? 'Invalid Email Address'
                            : null;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      return (value == '') ? 'Please enter your username' : null;
                    },
                    decoration: InputDecoration(hintText: 'Username'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      return (value == '') ? 'Please enter your password' : null;
                    },
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 15.5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var isFormValid = formKey.currentState!.validate();
                        if (isFormValid) {
                          _handleRegister();
                        }
                      },
                      child: Text('Sign up'))
                ],
              )),
        ),
      ),
    );
  }

  void _handleRegister() async {

    final String endpoint = 'http://ec2-54-251-136-115.ap-southeast-1.compute.amazonaws.com:3432/api/auth/v1/register';

    Map<String, String> body = {
      'email': emailController.text,
      'username': usernameController.text,
      'password': passwordController.text,
    };

    Map<String, String> headers = {
      'nodex-user-origin': 'mobile',
      'nodex-access-key': 'v7pb6wylg4m0xf0kx5zzoved',
      'nodex-secret-key': 'glrvdwi46mq00fg1oqtdx3rg',
      'Content-Type': 'application/json'
    };
    String requestBody = convert.jsonEncode(body);
    try {
      http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: requestBody,
      );
      var details = convert.jsonDecode(response.body);

      if (response.statusCode == 201) {
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

  _showMsg(msg) {
    final snackBar = SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
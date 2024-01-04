import 'package:final_capstone_furcare/Pages/Staff_Page/Main/customer_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  var formKey = GlobalKey<FormState>();
  var userData;
  var userToken;

  void _getInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var userJson = localStorage.getString('data');
    var user = convert.jsonDecode(userJson.toString());
    setState(() {
      userData = user;
      userToken = token;
    });
  }

  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController presentAdd = TextEditingController();
  TextEditingController permanentAdd = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: firstName,
                    validator: (value) {
                      return (value == '') ? 'Required' : null;
                    },
                    decoration: InputDecoration(hintText: 'First name'),
                  ),
                  TextFormField(
                    controller: lastName,
                    validator: (value) {
                      return (value == '') ? 'Required' : null;
                    },
                    decoration: InputDecoration(hintText: 'Last name'),
                  ),
                  TextFormField(
                    controller: birthdate,
                    validator: (value) {
                      return (value == '') ? 'Required' : null;
                    },
                    keyboardType: TextInputType.datetime,
                    decoration:
                    InputDecoration(hintText: '1990-02-20'),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: presentAdd,
                          validator: (value) {
                            return (value == '') ? 'Required' : null;
                          },
                          decoration: InputDecoration(hintText: 'Present Address'),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: permanentAdd,
                          validator: (value) {
                            return (value == '') ? 'Required' : null;
                          },
                          decoration:
                          InputDecoration(hintText: 'Permanent Address'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            return (value == '') ? 'Required' : null;
                          },
                          decoration:
                          InputDecoration(hintText: 'Email ex. test@gmail.com'),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: number,
                          validator: (value) {
                            return (value == '') ? 'Required' : null;
                          },
                          decoration: InputDecoration(hintText: 'Phone number'),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: gender,
                    validator: (value) {
                      return (value == '') ? 'Required' : null;
                    },
                    decoration: InputDecoration(hintText: 'Male'),
                  ),
                  SizedBox(
                    height: 15.5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var isFormValid = formKey.currentState!.validate();
                        if (isFormValid) {
                          _Addprofile();
                        }
                      },
                      child: Text('Add profile'))
                ],
              )),
        ),
      ),
    );
  }
  void _Addprofile() async {

    final String endpoint = 'http://ec2-54-251-136-115.ap-southeast-1.compute.amazonaws.com:3432/api/user/v1/profile';

    Map body = {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'birthdate': birthdate.text,
      'address':{
        'present': presentAdd.text,
        'permanent': permanentAdd.text
      },
      'contact':{
        'email': email.text,
        'number': number.text
      },
      'gender': gender.text,
    };


    Map<String, String> headers = {
      'nodex-user-origin': 'mobile',
      'nodex-access-key': 'v7pb6wylg4m0xf0kx5zzoved',
      'nodex-secret-key': 'glrvdwi46mq00fg1oqtdx3rg',
      'Content-Type': 'application/json'
    };
    String requestBody = convert.jsonEncode(body);
    print(requestBody);

    try {
      http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: requestBody,
      );

      var details = convert.jsonDecode(response.body);

      if (response.statusCode == 201) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.getString('data');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomerProfile()));
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

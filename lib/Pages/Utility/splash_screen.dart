import 'dart:async';
import 'package:final_capstone_furcare/Pages/Staff_Page/staff_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class LoadingA extends StatefulWidget {
  const LoadingA({Key? key}) : super(key: key);

  @override
  State<LoadingA> createState() => _LoadingAState();
}

class _LoadingAState extends State<LoadingA> {

  var userData;

  void _getInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = convert.jsonDecode(userJson.toString());

    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
    Timer(Duration(seconds: 3), (){
      // if(userData['role'] == 'Staff'){
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> StaffPage()));
      // } else if (userData['role'] == 'Customer') {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (_) => HomePage()));
      // }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => StaffPage()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/aaaaa.jpg', height: 120,),
            SizedBox(height: 20,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:final_capstone_furcare/Pages/Staff_Page/Main/Forms/customer_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  List customerProfile = <dynamic>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getCustomer() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("data");
    var user = convert.jsonDecode(userJson.toString());

    setState(() {
      customerProfile = user;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerForm()));
        }, child: Icon(Icons.plus_one),),
      body: ListView.builder(
          itemCount: customerProfile.length,
          itemBuilder: (context, index) {
              final customerProfiles = customerProfile[index] as Map;
              return Card(
                elevation: 10,
                color: Colors.white38,
                shadowColor: Colors.redAccent,
                child: ListTile(
                  title: const Icon(Icons.arrow_forward_ios_sharp),
                  trailing: Text(customerProfile[index]['firstName']),
                  subtitle: Text(customerProfile[index]['address']),
                ),
              );
          }
      ),
    );
  }
}

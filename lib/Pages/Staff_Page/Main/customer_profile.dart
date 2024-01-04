import 'package:final_capstone_furcare/Pages/Staff_Page/Main/Forms/customer_form.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerForm()));
      }, child: Icon(Icons.plus_one),),
    );
  }
}

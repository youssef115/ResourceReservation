import 'package:flutter/material.dart';
import 'package:flutter_spring/models/Register_model.dart';
import 'package:flutter_spring/models/User.dart';
import 'package:flutter_spring/screens/Home_screen.dart';
import 'package:flutter_spring/screens/login_screen.dart';
import 'package:flutter_spring/widgets/custom_ElevatedButton.dart';
import 'package:flutter_spring/widgets/custom_textField.dart';
import 'package:flutter_spring/widgets/customeCheckBox.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isRegister = false;
  bool isToolProvider = false;

  ResgisterModel registerObject = ResgisterModel();
  Future<void> register() async {
    //User? user;
    final String url = "http://10.0.2.2:8080/api/v1/auth/register";
    Map<String, dynamic> loginData = {
      "firstname": registerObject.firstName,
      "lastname": registerObject.lastName,
      "email": registerObject.email,
      "password": registerObject.password,
      "role": isToolProvider == false ? "USER" : "Provider",
      "cin": registerObject.cin,
      "address": registerObject.address,
      "phone":registerObject.phone
    };
    String jsonData = json.encode(loginData);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      var jsonresponse = json.decode(response.body);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));

      print('account create successfully successfully!');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SvgPicture.asset("images/register.svg",
                    width: 220, height: 220),
                const SizedBox(
                  height: 20,
                ),
              
                CustomCheckBox(title: "create tool provider account ?", 
                      value: isToolProvider,
                      onchange: (value){
                        setState(() {
                        isToolProvider=value!;
                          
                        });
                        print("ischecked");}
                        ),
                          SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.text,
                  label: "first name",
                  hint: "first name",
                  icon: Icons.person,
                  validation: (value) {
                    if (value == null || value.isEmpty == true)
                      return "the length of the first name must be greater than 0";
                    if (value.length > 3 && value.length < 30) return null;
                    return "it's look like the text entered is not an first name";
                  },
                  onsaved: (value) {
                    registerObject.setFirstName = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.text,
                  label: "last name",
                  hint: "last name",
                  icon: Icons.person,
                  validation: (value) {
                    if (value == null || value.isEmpty == true)
                      return "the length of the last name must be greater than 0";
                    if (value.length > 3 && value.length < 30) return null;
                    return "it's look like the text entered is not an last name";
                  },
                  onsaved: (value) {
                    registerObject.setLastName = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.number,
                  label: "CIN",
                  hint: "CIN",
                  icon: Icons.credit_card,
                  validation: (value) {
                    if (value == null || value.isEmpty == true)
                      return "the length of the name must be greater than 0";
                    if (value.length == 8) return null;
                    return "the number of CIN is composed by 8 numbers";
                  },
                  onsaved: (value) {
                    if (value != null) registerObject.setCin = int.parse(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.text,
                  label: "address",
                  hint: "address",
                  icon: Icons.location_city,
                  validation: (value) {
                    if (value == null || value.isEmpty == true)
                      return "the length of the address must be greater than 0";
                    if (value.length > 5 && value.length < 50) return null;
                    return "it's look like the text entered is not an address";
                  },
                  onsaved: (value) {
                    registerObject.setAddress = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.text,
                  label: "phone",
                  hint: "phone number",
                  icon: Icons.phone,
                  validation: (value) {
                    if (value == null || value.isEmpty == true)
                      return "the length of the address must be greater than 0";
                    if (value.length == 8) return null;
                    return "it's look like the number entered is not an phone number";
                  },
                  onsaved: (value) {
                    if (value != null)
                      registerObject.setPhone = int.parse(value);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.emailAddress,
                  label: "email",
                  hint: "email@exemple.com",
                  icon: Icons.email,
                  validation: (value) {
                    if (value == null || value.isEmpty == true)
                      return "the length of the email must be greater than 0";
                    if (!value.contains("@")) return "this is not en email";
                    if (value.length > 15 && value.length < 30) return null;
                    return "it's look like the text entered is not an email";
                  },
                  onsaved: (value) {
                    registerObject.setEmail = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.text,
                  label: "password",
                  hint: "password",
                  icon: Icons.password,
                  validation: (value) {
                    if (value == null || value.length == 0)
                      return "the field is empty";
                    if (value.length < 6)
                      return "the length of the password must be greater than 6";
                    if (value.length > 40)
                      return "this password is too long you must use a shorter password";
                  },
                  onsaved: (value) {
                    registerObject.setPassword = value;
                  },
                ),
                
                
                SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  titre: "Register",
                  taillText: 26,
                  couleur: Theme.of(context).colorScheme.primary,
                  onpressed: () async {
                    if (formkey.currentState!.validate()) {
                      ;
                      formkey.currentState!.save();
                      print(registerObject);
                      register();
                    } else {
                      print("non valid");
                      //dialogAlert(context);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("you do have an account?"),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text("login now",
                          style: TextStyle(color: Colors.purple)),
                    )
                  ],
                )
              ],
            ),
          )),
    ));
    ;
  }
  
}

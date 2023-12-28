import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/User.dart';
import 'package:flutter_spring/models/Login_model.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:flutter_spring/screens/Home_screen.dart';
import 'package:flutter_spring/screens/register_screen.dart';
import 'package:flutter_spring/widgets/custom_ElevatedButton.dart';
import 'package:flutter_spring/widgets/custom_textField.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  
  final formkey = GlobalKey<FormState>();

  LoginModel loginObject = LoginModel();
  
   User user=User();
   String token="";
   String email="";

  Future<void> login() async {
    //User? user;
    final String url = "http://10.0.2.2:8080/api/v1/auth/login";
    Map<String, dynamic> loginData = {
      'email': loginObject.email,
      'password': loginObject.password,
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
        email=loginObject.email;
        token=jsonresponse["access_token"];
      print('Data sent successfully!');
    } else {
      print('Error: ${response.statusCode}');
    }

    
  }


Future<void> fetchUserData(String token ,String email)async{
 
    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/userinfo/$email');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          var resjson = jsonDecode(response.body);
          user.setToken=token;
          user.setEmail=email;
          user.setFirstname=resjson["response"]["firstname"];
          user.setLastname=resjson["response"]["lastname"];
          user.setCin=resjson["response"]["cin"];
          user.setRole=resjson["response"]["role"]; 
        });
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
       
      }
    } catch (error) {
      print('Exception while fetching user data: $error');
     
    }
}


 Future<void> storeToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if(token !=null)
    await prefs.setString('token', token);
}

Future<void> storeEmail(String email)async{
  final prefs=await SharedPreferences.getInstance();
  await prefs.setString("email", email);
}


  @override
  Widget build(BuildContext context) {
    //final user = ref.watch(userProvider);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                SvgPicture.asset("images/login.svg", width: 220, height: 220),
                const SizedBox(
                  height: 20,
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
                    loginObject.setEmail = value;
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
                    loginObject.setPassword = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  titre: "login",
                  taillText: 26,
                  couleur: Theme.of(context).colorScheme.primary,
                  onpressed: () async {
                    if (formkey.currentState!.validate()) {
                      ;
                      formkey.currentState!.save();
                      //print(loginObject);

                      await login();
                      if (token != "") {
                        storeToken(token);
                        storeEmail(loginObject.email);
                        fetchUserData(token, email);
                         ref.watch(userProvider.notifier).login(user);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("wrong credentials")));
                      }
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
                    Text("you don't have account?"),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                      },
                      child: Text("register now",
                          style: TextStyle(color: Colors.purple)),
                    )
                  ],
                )
              ],
            ),
          )),
    ));
  }
}

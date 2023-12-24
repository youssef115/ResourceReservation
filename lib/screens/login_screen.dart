import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spring/models/Login_model.dart';
import 'package:flutter_spring/screens/Home_screen.dart';
import 'package:flutter_spring/screens/register_screen.dart';
import 'package:flutter_spring/widgets/custom_ElevatedButton.dart';
import 'package:flutter_spring/widgets/custom_textField.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  var loginObject = LoginModel();

  @override
  Widget build(BuildContext context) {
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
                SvgPicture.asset("images/login.svg",width: 220,height:220),
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
                      print(loginObject);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    } else {
                      print("non valid");
                      //dialogAlert(context);
                    }
                  },
                ),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("you don't have account?"),
                    SizedBox(width: 2,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterScreen()));
                      },
                      child: Text("register now" ,style:TextStyle(color: Colors.purple)),
                    )
                  ],
                )
              ],
            ),
          )),
    ));
  }

}

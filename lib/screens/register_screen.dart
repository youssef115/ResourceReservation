import 'package:flutter/material.dart';
import 'package:flutter_spring/models/Register_model.dart';
import 'package:flutter_spring/screens/Home_screen.dart';
import 'package:flutter_spring/screens/login_screen.dart';
import 'package:flutter_spring/widgets/custom_ElevatedButton.dart';
import 'package:flutter_spring/widgets/custom_textField.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
     final formkey = GlobalKey<FormState>();

     var registerObject=ResgisterModel();
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
                  height: 40,
                ),
                SvgPicture.asset("images/register.svg",width: 220,height:220),
                const SizedBox(
                  height: 20,
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
                   registerObject.setFirstName=value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),CustomTextField(
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
                   registerObject.setLastName=value;
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
                    if(value!=null)
                    registerObject.setCin=int.parse(value);
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
                    if (value.length > 15 && value.length < 50) return null;
                    return "it's look like the text entered is not an address";
                  },
                  onsaved: (value) {
                   registerObject.setAddress=value;
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
                    if (value.length ==8) return null;
                    return "it's look like the number entered is not an phone number";
                  },
                  onsaved: (value) {
                   if(value!=null)
                   registerObject.setPhone=int.parse(value);
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
                   registerObject.setEmail=value;
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
                   registerObject.setPassword=value;
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
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (context) => HomeScreen()));
                         
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
                    Text("you do have an account?"),
                    SizedBox(width: 2,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Text("login now" ,style:TextStyle(color: Colors.purple)),
                    )
                  ],
                )
              ],
            ),
          )),
    ));;
  }
}
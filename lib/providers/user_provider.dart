

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/User.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

final userProvider=StateNotifierProvider<UserController,User?>
((ref) => UserController());

class UserController extends StateNotifier<User?>{
  UserController():super(null);

  void login(User user){
    
    state=user;

  }

  void logout(){
    state=null;
  }

}

  // Future<User?> getUserByEmail(String email,String token) async {
  //   User? user;
  //   final response = await http.get(
  //     Uri.parse("http://10.0.2.2:8080/api/v1/userinfo/$email"),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       "Authorization":"Bearer $token"
  //     }
  //   );
  //   if (response.statusCode == 200) {
  //     print("////////${json.decode(response.body)}");
  //     var jsonresponse = json.decode(response.body);
  //     print(" the first name ${jsonresponse["firstname"]}");
  //     user=User(token: token,email: email,firstname:jsonresponse["firstname"],lastname: jsonresponse["lastname"],cin: jsonresponse["cin"],role: jsonresponse["role"]);
     
  //     print('get the user data successfully! ${user.firstname}');
  //   } else {
  //     print('Error: ${response.statusCode}');
  //   }

  //   return user;
  // }


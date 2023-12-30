import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/Category_model.dart';
import 'package:flutter_spring/models/User.dart';
import 'package:flutter_spring/providers/favorites_provider.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:flutter_spring/screens/CategoryScreen.dart';
import 'package:flutter_spring/screens/login_screen.dart';
import 'package:flutter_spring/screens/mangeToolScreen.dart';
import 'package:flutter_spring/screens/serverProblem.dart';
import 'package:flutter_spring/screens/tool_screen.dart';
import 'package:flutter_spring/widgets/Category_grid_item.dart';
import 'package:flutter_spring/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _token = '';
  String _email='';
  List<Category> _data = [];
  User user=User();
  bool _isLoading = true;
  bool isServerProblem=false;
  @override
  void initState() {
    super.initState();
    _getData();
    
  }

  Future<void> _getData() async {
    await _getToken();
    await _getEmail();
    await fetchData();
    await fetchUserData();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    setState(() {
      _token = token;
    });
  }

  Future<void> fetchData() async {
    if (_token.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    //print(_token);

    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/category');
    Map<String, String> headers = {'Authorization': 'Bearer $_token'};

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          var resjson = jsonDecode(response.body);

          _data = List<Category>.from(resjson["response"].map((item) =>
              Category(
                  id: item['id'].toString(),
                  title: item['title'].toString(),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5))));

          //print(_data);
          _isLoading = false;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Exception while fetching data: $error');
      setState(() {
        _isLoading = false;
        isServerProblem=true;
      });
    }
  }

 Future<void> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    _email=email;
  }
 
 Future<void> fetchUserData()async{
  if (_token.isEmpty || _email.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    //print(_token);

    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/userinfo/$_email');
    Map<String, String> headers = {'Authorization': 'Bearer $_token'};

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          var resjson = jsonDecode(response.body);
          user.setToken=_token;
          user.setEmail=_email;
          user.setFirstname=resjson["response"]["firstname"];
          user.setLastname=resjson["response"]["lastname"];
          user.setCin=resjson["response"]["cin"];
          user.setRole=resjson["response"]["role"];
          ref.read(userProvider.notifier).login(user);
          _isLoading = false;
        });
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Exception while fetching user data: $error');
      setState(() {
        _isLoading = false;
        isServerProblem=true;
      });
    }
 }
  @override
  Widget build(BuildContext context) {
      
    void _setScreen(String identifier) {
      if(identifier=="logout"){
            Navigator.push(context,MaterialPageRoute(builder:(context)=>const LoginScreen()));
      }
      else if (identifier == "favorite") {
        final tool=ref.watch(favoriteToolProviders);
        Navigator.of(context).pop();
        Navigator.push(context,MaterialPageRoute(builder:(context)=>ToolScreen(title: "Favorite tools",tools: tool,)));
      }else if(identifier == "manage Tool"){
          Navigator.of(context).pop();
          Navigator.push(context,MaterialPageRoute(builder:(context)=>MnageToolScreen()));
      } 
      else {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: isServerProblem?null:AppBar(
        title: Text("Home Screen"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.background, fontSize: 24),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: Center(
          child: isServerProblem? ServerProblemScreen(): 
              _isLoading
              ? CircularProgressIndicator() // Show a loader while fetching data
              : _data.isEmpty
                  ? Text('No data available ...')
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      child: CategoryScreen(
                        categoryList: _data,
                      ))),

      // Container(
      //   color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      //   child: CategoryScreen()
      //)
    );
  }
}

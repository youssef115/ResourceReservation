import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
class MnageToolScreen extends ConsumerStatefulWidget {
  const MnageToolScreen({super.key});

  @override
  ConsumerState<MnageToolScreen> createState() => _MnageToolScreenState();
}

class _MnageToolScreenState extends ConsumerState<MnageToolScreen> {
  List<Tool> tools=[];
  bool _isLoading = true;
  bool isServerProblem=false;

   @override
  void initState() {
    super.initState();
    fetchToolsByProvider();
    
  }
  

  Future<void> fetchToolsByProvider()async{
    var user=ref.read(userProvider);
    String? token =user!.token;
    String? email=user!.email;
  if (token==null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/tool/tools-by-email/$email');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var resjson=jsonDecode(response.body);
        print(resjson["response"]);
        setState(() {
        
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Mange Tool"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontSize: 22),
      ),
      body: Container(
          child: Column(
            children: [
                for (final tool in tools)
                ListTile(
                  title: Text(tool.title),
                )
            ],
          ),
      ),
    );
  }
}
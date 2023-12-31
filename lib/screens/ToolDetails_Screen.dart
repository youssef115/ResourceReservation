import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/Status.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/favorites_provider.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ToolDetailScreen extends ConsumerWidget {
  const ToolDetailScreen({super.key, required this.tool});

  final Tool tool;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   bool isReserved=false;

Future<void> reservTool() async {
    final user=ref.read(userProvider);
    final token=user!.getToken;
    final String url = "http://10.0.2.2:8080/api/v1/reservation";
    Map<String, dynamic> reservationData = 
    {
  "time": DateTime.now().millisecondsSinceEpoch,
  "duration": 1,
  "userReservation": {
    "id": user.getId
  },
  "toolReservation": {
    "id": tool.getId 
  }
}
    ;
    String jsonData = json.encode(reservationData);

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonData,
    );
    if (response.statusCode == 200) {
      var jsonresponse = json.decode(response.body);
      isReserved=true;
       //print(jsonresponse);
      print('Data sent successfully!');
    } else {
      print('Error: ${response.statusCode}');
      print(response.body);
    }

    
  }

    final favoriteTool = ref.watch(favoriteToolProviders);
    bool isExist = favoriteTool.contains(tool);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteToolProviders.notifier)
                  .toggleToolFavoriteStuts(tool);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(wasAdded
                      ? "added to favorites "
                      : "removed from favorites")));
            },
            icon: Icon(
              Icons.star,
              color: isExist ? Colors.yellow : Colors.grey,
            ),
          ),
        ],
        title: Text(
          "${tool.title}",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.network(
                tool.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'description',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                tool.smallDescription,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
                Text(isReserved==false?
                tool.status==Status.AVAILABLE? "Available" : tool.status==Status.RESERVED? "Reserved" :"Out of Service":"Reserved",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color:tool.status==Status.AVAILABLE? Colors.green: tool.status==Status.RESERVED? Colors.yellow :Colors.red, ),
              ),
              ElevatedButton(
                onPressed: () {
                  if(isReserved==false && tool.status==Status.AVAILABLE){
                    reservTool();
                    ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("your reservation is done successfully")));
                  }
                  else{
                    ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("you can't reserve a reserved tool")));
                  }
                },
                
                child: const Text("Reserve it now",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
        ),
      ),
    );
  }
}

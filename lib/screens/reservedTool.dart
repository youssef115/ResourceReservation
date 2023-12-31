import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/Reserved_model.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ReservedTool extends ConsumerStatefulWidget {
  const ReservedTool({super.key});

  @override
  ConsumerState<ReservedTool> createState() => _ReservedToolState();
}

class _ReservedToolState extends ConsumerState<ReservedTool> {
  List<ReservedTools> reservedtools=[];
 


   @override
  void initState() {
    super.initState();
    fetchReservedTools();
    
  }

  double calculatePriceOfReservation(int time,double priceParHoure){
    return getDaysBetweenDates(time)*priceParHoure*24;
  }
  int getDaysBetweenDates(int time){
    return  DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).difference(DateTime.fromMillisecondsSinceEpoch(time)).inDays +1;
  }

  Future<void> fetchReservedTools()async{
    var user=ref.read(userProvider);
    String? token =user!.token;
    String? email=user!.email;
 
    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/reservation/query?email=${email}');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var resjson=jsonDecode(response.body);
        print(resjson["response"]);

        setState(() {
        reservedtools=List<ReservedTools>.from(resjson["response"].map((item) =>
         
             ReservedTools(
              id: item["id"],
               duration: item["duration"],
               time: item["time"],
               userId: item["userReservation"]["id"],
               tool: Tool(
                id: item["toolReservation"]["id"],
                title: item["toolReservation"]["title"],
                imageUrl: item["toolReservation"]["imageUrl"],
                smallDescription:item["toolReservation"]["smallDescription"] ,
                rentPriceParHour:item["toolReservation"]["rentPriceParHour"] ,
               ),
             ),
             
         
             ));
          
          
        });
       
        
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
       
      }
    } catch (error) {
      print('Exception while fetching user data: $error');
      
    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Reserved Tools"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontSize: 22),
      ),
      body: LiquidPullToRefresh(
        onRefresh: fetchReservedTools,
        color:Colors.deepPurple,
        height: 100,
        child: ListView.builder(
          itemCount: reservedtools.length,
          itemBuilder: (context,i){
          return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                       const SizedBox(height: 10,),
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        title: Text("${reservedtools[i].tool?.getTitle}"),
                        subtitle: Text("${reservedtools[i].tool?.getSmallDescription}"),
                        leading: const Icon(Icons.build),
                        trailing: Container(
                          width: 68,
                          child: Text("${calculatePriceOfReservation(reservedtools[i].time,reservedtools[i].tool?.getRentPriceParHour)} DT"),
                        ),
                        
                      ),
                    ],
                  ),
                );
        }),
      )
    );
  }
}
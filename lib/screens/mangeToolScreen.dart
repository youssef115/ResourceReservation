import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/Status.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:flutter_spring/screens/editToolScreen.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
        //print(resjson["response"]);

        setState(() {
        tools=List<Tool>.from(resjson["response"].map((item) =>
              Tool(
                  id: item["id"],
                  title: item["title"],
                  category: item["category"]["id"],
                  imageUrl: item["imageUrl"],
                  smallDescription: item["smallDescription"],
                  rentPriceParHour: item["rentPriceParHour"],
                  status: item["status"]=="AVAILABLE"?
                  Status.AVAILABLE:item["status"]=="RESERVED"?
                  Status.RESERVED:Status.OUT_OF_SERVICE,
                )));
          
          _isLoading = false;
        });
        print("list of tools $tools");
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
 
  Future<void>deleteTool(int id)async{
 var user=ref.read(userProvider);
    String? token =user!.token;

    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/tool/$id');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    try {
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        //var resjson=jsonDecode(response.body);
        //print(resjson["response"]);

       fetchToolsByProvider();
        //print("list of tools $tools");
        print("deleted successfully");
      } else {
        print('Failed to delete the element : ${response.statusCode}');
      
      }
    } catch (error) {
      print('Exception while fetching user data: $error');
    
    }
 }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mange Tool"),
        actions: [
          InkWell(
            onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>EditToolScreen(tool: null)));
            },
            child: Icon(Icons.add,color: Theme.of(context).colorScheme.background,),
          ),
          const SizedBox(width: 15,),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontSize: 22),
      ),
      body: LiquidPullToRefresh(
        onRefresh: fetchToolsByProvider,
        color:Colors.deepPurple,
        height: 100,
        child: ListView.builder(
          itemCount: tools.length,
          itemBuilder: (context,i){
          return tools==[]?CircularProgressIndicator():Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                       const SizedBox(height: 10,),
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        title: Text(tools[i].title),
                        subtitle: Text(tools[i].smallDescription),
                        leading: const Icon(Icons.build),
                        trailing: Container(
                          width: 68,
                          child: Row(
                            children: [
                              InkWell(onTap: (){
                                //open update tool screen
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>EditToolScreen(tool: tools[i])));
                              },child: const Icon(Icons.edit)),
                              const SizedBox(width: 18,),
                              InkWell(onTap: (){
                                //delete tool
                               //print("the tool id ${tools[i].id}");
                                deleteTool(tools[i].id);
                                
                              },child: const Icon(Icons.delete)),
                           
                            ],
                          ),
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




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/data/dummy_data.dart';
import 'package:flutter_spring/models/Category_model.dart';
import 'package:flutter_spring/models/Status.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:flutter_spring/screens/tool_screen.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
class CategoryGridItem extends ConsumerStatefulWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  @override
  ConsumerState<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends ConsumerState<CategoryGridItem> {
  List<Tool> tools = [];


  @override
  void initState() {
    
    super.initState();
     Future.delayed(const Duration(milliseconds: 2000), () {
        fetchData();
      });
  }

  Future<void> fetchData() async {
   final user=ref.read(userProvider);
   final token = user!.token;
   //print(user!.getToken);
    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/tool/category/${widget.category.getTitle}');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    try {
      print(widget.category.getTitle);
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          var resjson = jsonDecode(response.body);
            print(resjson["response"]);
          tools = List<Tool>.from(resjson["response"].map((item) =>
              Tool(
                  id: item['id'],
                  category:int.parse(widget.category.getId),
                  title: item['title'],
                  imageUrl: item["imageUrl"],
                  smallDescription: item["smallDescription"],
                  rentPriceParHour: item["rentPriceParHour"],
                  status: item["status"]=="AVAILABLE"?Status.AVAILABLE:item["status"]=="RESERVED"?Status.RESERVED:Status.OUT_OF_SERVICE
                  
                  )));
          
          print("get the data successfully");
         
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        //print("${response.body}");
       
      }
    } catch (error) {
      print('Exception while fetching data: ${error}');
    
    }
  }

  @override
  Widget build(BuildContext context) {
    
   
    return InkWell(
      onTap: () {
        final List<Tool> filteredTool = tools;
            // .where((element) => element.category.toString()==widget.category.id)
            // .toList();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ToolScreen(title: widget.category.title, tools:filteredTool)));
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [
                widget.category.color.withOpacity(0.9),
                widget.category.color.withOpacity(0.54),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Text(widget.category.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  ))),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/Category_model.dart';
import 'package:flutter_spring/models/Status.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:flutter_spring/widgets/custom_ElevatedButton.dart';
import 'package:flutter_spring/widgets/custom_textField.dart';
import "dart:convert";
import "package:http/http.dart" as http;

class EditToolScreen extends ConsumerStatefulWidget {
  const EditToolScreen({super.key, required this.tool});
  final Tool? tool;

  @override
  ConsumerState<EditToolScreen> createState() => _EditToolScreenState();
}

class _EditToolScreenState extends ConsumerState<EditToolScreen> {
  String? status;
  Tool updatedTool = Tool();
  final formkey = GlobalKey<FormState>();
  List<Category> category = [];
  Category? categoryChoosen;

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    var user = ref.read(userProvider);
    String? token = user!.token;

    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/category');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          var resjson = jsonDecode(response.body);

          category = List<Category>.from(resjson["response"].map((item) =>
              Category(
                  id: item['id'].toString(),
                  title: item['title'].toString(),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.5))));

          print(category);
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        setState(() {});
      }
    } catch (error) {
      print('Exception while fetching data: $error');
    }
  }

  Future<void> updateTool() async {
    var user = ref.read(userProvider);
    String? token = user!.token;

    Uri url = Uri.parse('http://10.0.2.2:8080/api/v1/tool');
    Map<String, dynamic> updateData = {
      "id": widget.tool!.getId,
      "title": updatedTool.getTitle,
      "category": {
        "id": categoryChoosen == null
            ? widget.tool!.getCategory
            : categoryChoosen?.getId
      },
      "user": {"id": user.id},
      "imageUrl": updatedTool.getImageUrl,
      "smallDescription": updatedTool.getSmallDescription,
      "rentPriceParHour": updatedTool.getRentPriceParHour,
      "status": updatedTool.getStatus == Status.AVAILABLE
          ? "AVAILABLE"
          : updatedTool.getStatus == Status.RESERVED
              ? "RESERVED"
              : "OUT_OF_SERVICE",
    };
    //print(updateData);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      http.Response response =
          await http.put(url, headers: headers, body: json.encode(updateData));
      if (response.statusCode == 200) {
        var resjson = json.decode(response.body);
        //print(resjson["response"]);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("update is done successfully")));

        //print("list of tools $tools");
        print("updated successfully");
      } else {
        print('Failed to update the element : ${response.statusCode}');
        print("${response.body}");
      }
    } catch (error) {
      print('Exception while fetching user data: $error');
    }
  }

  Future<void> addTool() async {
    final user = ref.read(userProvider);
    final token = user!.getToken;
    final String url = "http://10.0.2.2:8080/api/v1/tool";
    Map<String, dynamic> addToolData = {
      //in the case of adding a tool the updateTool will work as addTool object
      "title": updatedTool.getTitle,
      "category": {"id": categoryChoosen!.getId},
      "user": {"id": user.id},
      "imageUrl": updatedTool.getImageUrl,
      "smallDescription": updatedTool.getSmallDescription,
      "rentPriceParHour": updatedTool.getRentPriceParHour,
      "status": updatedTool.getStatus == Status.AVAILABLE
          ? "AVAILABLE"
          : updatedTool.getStatus == Status.RESERVED
              ? "RESERVED"
              : "OUT_OF_SERVICE",
    };
    String jsonData = json.encode(addToolData);

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
      print(jsonresponse);
      print('Data sent successfully!');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? toolStatus;
    if (widget.tool != null) {
      toolStatus = widget.tool!.status == Status.AVAILABLE
          ? "AVAILABLE"
          : widget.tool!.status == Status.RESERVED
              ? "RESERVED"
              : "OUT_OF_SERVICE";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.tool != null ? "Update Tool" : "Add a new tool"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 22),
        ),
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
                    CustomTextField(
                      typeClavier: TextInputType.text,
                      label: "title",
                      hint: "enter the title of the tool",
                      initialValue:
                          widget.tool == null ? null : "${widget.tool!.title}",
                      validation: (value) {
                        if (value == null || value.isEmpty == true)
                          return "the length of the title must be greater than 0";

                        if (value.length > 5 && value.length < 30) return null;
                        return "it's look like the text entered can't be a title";
                      },
                      onsaved: (value) {
                        updatedTool.setTitle = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      typeClavier: TextInputType.text,
                      label: "Description",
                      hint: "enter a small description for the tool",
                      initialValue: widget.tool == null
                          ? null
                          : "${widget.tool!.smallDescription}",
                      validation: (value) {
                        if (value == null || value.isEmpty == true)
                          return "the length of the description must be greater than 0";

                        if (value.length > 15 && value.length < 30) return null;
                        return "it's look like the text entered is not a description";
                      },
                      onsaved: (value) {
                        updatedTool.setSmallDescription = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      typeClavier: TextInputType.number,
                      label: "rent",
                      hint: "enter the rent par hour",
                      initialValue: widget.tool == null
                          ? null
                          : "${widget.tool!.rentPriceParHour}",
                      validation: (value) {
                        if (value == null || value.isEmpty == true)
                          return "the length of rent than 0";

                        if (value.length > 0 && value.length < 4) return null;
                        // return "it's look like the value entered is not valid for renting a tool";
                      },
                      onsaved: (value) {
                        if (value != null)
                          updatedTool.setRentPriceParHour = double.parse(value);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.tool != null
                        ? "current status : ${toolStatus}"
                        : ""),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text(widget.tool != null
                              ? "update Status : "
                              : "choose the status"),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                            value: status,
                            items: <String>[
                              'AVAILABLE',
                              'RESERVED',
                              "OUT_OF_SERVICE"
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  status = value;
                                  print(status);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Text(widget.tool != null
                        ? "current category : ${widget.tool!.category}"
                        : ""),
                    Center(
                      child: Row(
                        children: [
                          Text(widget.tool != null
                              ? "update category : "
                              : "choose the category"),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                            value: categoryChoosen?.title,
                            items: category.map((Category value) {
                              return DropdownMenuItem<String>(
                                value: value.getTitle,
                                child: Text(value.getTitle),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  //categoryChoosen?.setTitle = value;
                                  for (final i in category) {
                                    if (i.getTitle == value)
                                      categoryChoosen = i;
                                    print(
                                        "the category choosen is ${categoryChoosen?.getTitle}");
                                    print(
                                        "the category choosen is ${categoryChoosen?.getId}");
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                      titre: widget.tool != null
                          ? "update too info"
                          : "add new tool",
                      taillText: 20,
                      couleur: Theme.of(context).colorScheme.primary,
                      onpressed: () async {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();

                          updatedTool.setStatus = status == "AVAILABLE"
                              ? Status.AVAILABLE
                              : status == "RESERVED"
                                  ? Status.RESERVED
                                  : Status.OUT_OF_SERVICE;

                          updatedTool.setImageUrl =
                              "https://rentrax.com/wp-content/uploads/2021/11/Why-Equipment-Rental-is-Better-Than-Buying.jpg";
                          if (widget.tool != null) {
                            updateTool();
                          } else {
                            if (updatedTool.getStatus != null &&
                                categoryChoosen != null) {
                              addTool();
                            } else {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("you must choose the status and the category")));
                            }
                          }
                        } else {
                          print("non valid");
                        }
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}

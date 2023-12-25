import 'package:flutter/material.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:flutter_spring/screens/ToolDetails_Screen.dart';
import 'package:flutter_spring/widgets/Tool_item.dart';

class ToolScreen extends StatelessWidget {
  const ToolScreen({super.key,this.title,required this.tools});

  final String? title;
  final List<Tool> tools;

  @override
  Widget build(BuildContext context) {
    return title==null? content(context): Scaffold(
      appBar: AppBar(
        title: Text(title!),
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.background,fontSize: 24),
        
      ),
      body: content(context),
    );
  }

  SingleChildScrollView content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: tools
            .map((e) => ToolItem(
                  tool: e,
                  onSelectTool: (Tool tool) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ToolDetailScreen(tool: tool,)));
                  },
                ))
            .toList(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/providers/favorites_provider.dart';
import 'package:flutter_spring/screens/CategoryScreen.dart';
import 'package:flutter_spring/screens/tool_screen.dart';
import 'package:flutter_spring/widgets/drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

     void _setScreen(String identifier){
      if(identifier=="favorite"){
        final tool=ref.watch(favoriteToolProviders);
         Navigator.of(context).pop();
        Navigator.push(context,MaterialPageRoute(builder:(context)=>ToolScreen(title: "Favorite tools",tools: tool,)));
      }else{
        Navigator.of(context).pop();
      }
  }

    return Scaffold(
      appBar: AppBar(
        title:Text("Home Screen"),
          backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.background,fontSize: 24),
      ),
      drawer:MainDrawer(onSelectScreen: _setScreen,),
      body:Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        child: CategoryScreen())
    );
  }

  
}
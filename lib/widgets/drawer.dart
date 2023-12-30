import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spring/models/User.dart';
import 'package:flutter_spring/providers/user_provider.dart';
import 'package:flutter_spring/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends ConsumerWidget {


  const MainDrawer({super.key, required this.onSelectScreen});

final void Function(String identifier) onSelectScreen;


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final user=ref.watch(userProvider);
    
    return  Drawer(
      child: Column(
        children: [
         
          UserAccountsDrawerHeader(
              accountEmail: Text("${user!.email}"),
              accountName: Text("${user.firstname}"),
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage("https://th.bing.com/th/id/R.7ff5ebcfa5294824c9f7b5ee217ed7b6?rik=LlFSVdeqUmr6zg&pid=ImgRaw&r=0"),
              )
            ),
                ListTile(
                  onTap: (){
                    onSelectScreen("tool");
                  },
                  leading: Icon(Icons.build,color: Theme.of(context).colorScheme.onBackground,),
                  title:Text("tool",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),),
                ),
                ListTile(
                  onTap: (){
                    onSelectScreen(user!.role=="Provider"?"manage Tool":"favorite");
                  },
                  leading: Icon(user!.role=="Provider"?Icons.settings:Icons.favorite,color: Theme.of(context).colorScheme.onBackground,),
                  title:Text(user!.role=="Provider"?"manage Tool":"favorite",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),),
                ),

                ListTile(
                  onTap: (){
                    deleteToken();
                   onSelectScreen("logout");

                  },
                  leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.onBackground,),
                  title:Text("Logout",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),),
                ),
                
        ],
      ),
    );
  }
  
  void deleteToken()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
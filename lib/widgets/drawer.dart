import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  const MainDrawer({super.key, required this.onSelectScreen});

final void Function(String identifier) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: [
         
          UserAccountsDrawerHeader(
              accountEmail: Text("email@email.com"),
              accountName: Text("username"),
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
                    onSelectScreen("favorite");
                  },
                  leading: Icon(Icons.favorite,color: Theme.of(context).colorScheme.onBackground,),
                  title:Text("favorite",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                ),),
                ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_spring/main.dart';
import 'package:flutter_spring/widgets/Nointernet.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(	// key if you want to add
        onRefresh: (){
          return Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(context,MaterialPageRoute(builder:(context)=>MyApp()));
          });
          
        },	
        child: Center(
          child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SvgPicture.asset("images/waiting.svg", width: 220, height: 220),
                 SizedBox(height: 20,),
                 CircularProgressIndicator(color: Theme.of(context).colorScheme.primary.withOpacity(0.5),),
                  //NoInternet()
              ],
            )
          ),
        ),
      ),
    );
  }
}
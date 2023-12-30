import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServerProblemScreen extends StatelessWidget {
  const ServerProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
      body:  Center(
          child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SvgPicture.asset("images/404.svg", width: 280, height: 280),
                 SizedBox(height: 20,),
                 Text("Server Problem 500 !!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20, fontWeight: FontWeight.bold),),
               
              ],
            )
          ),
        ),
      
    );
    
  }
}
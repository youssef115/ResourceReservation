import 'package:flutter/material.dart';
import 'package:flutter_spring/models/tool_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ToolItem extends StatelessWidget {
  const ToolItem({super.key, required this.tool, required this.onSelectTool});

  final Tool tool;
  final void Function(Tool tool) onSelectTool;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
    
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child:InkWell(
        onTap:()=>onSelectTool(tool),
        child: Stack(
          children: [
           FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(tool.imageUrl),height: 250,width: double.infinity,),
          Positioned(
            bottom: 0,
            right: 0 ,
            left: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 44,
                  ),
                  color: Colors.black54,
                  child:Column(
                    children: [
                      Text(tool.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize:24,
                      color:Colors.white,
                      fontWeight: FontWeight.bold
                       ),
                      ),
                      const SizedBox(height: 12,),
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule ,color: Theme.of(context).colorScheme.background),
                            const SizedBox(width: 6,),
                            const Text("1 day",style: TextStyle(color: Colors.white,fontSize: 20),)
                          ],
                        ),  
                        Row(
                          children: [
                            Icon(Icons.attach_money,color: Theme.of(context).colorScheme.background),
                            const SizedBox(width: 6,),
                            Text("${tool.rentPriceParHour}",style: TextStyle(color: Colors.white,fontSize: 20),)
                          ],
                        ),
                      ],
                    ),
                  )
                    ],
                  )
                ),
                
              ],
            ),
          ),
          ],
        ),
        
      )
    );
  }
}
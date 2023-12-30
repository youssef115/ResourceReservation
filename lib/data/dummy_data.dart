import 'package:flutter/material.dart';
import 'package:flutter_spring/models/Category_model.dart';
import 'package:flutter_spring/models/tool_model.dart';

const List<Category> availableCategories = [
  Category(
    id: '1',
    title: 'light Tools',
    color: Colors.purple,
  ),
  Category(
    id: '2',
    title: 'heavy Tools',
    color: Colors.red,
  ),
  Category(
    id: '3',
    title: 'Electronic Tools',
    color: Colors.orange,
  ),];

  // const List<Tool> dummyTools=
  //   [
  //     Tool({
  //       id:1,
  //       category: 3 ,
  //       title:"Cordless Drill"  ,
  //       imageUrl:"https://i.ebayimg.com/images/g/2KkAAOSwVFpffg0J/s-l640.jpg" ,
  //       smallDescription :"Versatile tool for drilling holes and driving screws" ,
  //       rentPriceParHour : 15.00
  //     }),
  //     //  Tool(
  //     //   id:2,
  //     //   category: 3 ,
  //     //   title:"Circular Saw"  ,
  //     //   imageUrl:"https://householdsales.net/wp-content/uploads/2017/07/CIRCULAR-Compact-SAW-WORX-4.5-Inch-W-X-429L-Electric-Tool-Corded-PORTABLE5.jpg" ,
  //     //   smallDescription :"Powerful saw for cutting wood, metal, and other materials" ,
  //     //   rentPriceParHour : 20.00
  //     // ),
  //      Tool(
  //       id:3,
  //       category: 3 ,
  //       title:"Rotary Hammer"  ,
  //       imageUrl:"https://i.ytimg.com/vi/Jrr-BgsGucg/maxresdefault.jpg" ,
  //       smallDescription :"Heavy-duty tool for drilling into concrete and masonry" ,
  //       rentPriceParHour : 30.00
  //     ),
  // //  Tool(
  // //       id:4,
  // //       category: 3 ,
  // //       title:"Heat Gun"  ,
  // //       imageUrl:"https://controlscentral.com/product_pictures/Large/69092.jpg" ,
  // //       smallDescription :"Versatile tool for stripping paint, softening plastics, and more" ,
  // //       rentPriceParHour :10.00
  // //     ),


  // // Tool(
  // //       id: 5,
  // //       category: 3 ,
  // //       title:"Laser Level"  ,
  // //       imageUrl:"https://s3-production.bobvila.com/articles/wp-content/uploads/2020/04/The-Best-Laser-Level-for-Home-Use-Option.jpg" ,
  // //       smallDescription :"Projects precise laser lines for leveling and aligning tasks" ,
  // //       rentPriceParHour :25.00
  // //     ),
  //  Tool(
  //       id:6,
  //       category: 1 ,
  //       title:"Claw Hammer"  ,
  //       imageUrl:"https://i.pinimg.com/originals/55/cf/82/55cf8201010b3955ee97d4e42758eaa1.jpg" ,
  //       smallDescription :"Essential tool for driving nails and prying objects" ,
  //       rentPriceParHour :5.00
  //     ),
  //  Tool(
  //       id:7,
  //       category: 1 ,
  //       title:"Tape Measure"  ,
  //       imageUrl:"https://i2.wp.com/boingboing.net/wp-content/uploads/2014/10/tape_measure.jpg" ,
  //       smallDescription :"Used for measuring distances and marking cuts" ,
  //       rentPriceParHour :2.00
  //     ),
  // Tool(
  //       id:8,
  //       category: 1 ,
  //       title:"Screwdriver Set"  ,
  //       imageUrl:"https://th.bing.com/th/id/R.f89d3188371df0efded63b411e424339?rik=tSpVJyN%2bPktmLA&riu=http%3a%2f%2fc.shld.net%2frpx%2fi%2fs%2fi%2fspin%2fimage%2fspin_prod_951023512%3fwid%3d800%26hei%3d800%26op_sharpen%3d1&ehk=6t7Nbn0zKAc5C644%2fZ3L5rtli1gGd6e9XsYGNF7hT%2bo%3d&risl=&pid=ImgRaw&r=0" ,
  //       smallDescription :"Includes various screwdrivers for different screw types" ,
  //       rentPriceParHour : 8.00
  //     ),
  // Tool(
  //       id:9,
  //       category: 1 ,
  //       title:"Level"  ,
  //       imageUrl:"https://th.bing.com/th/id/OIP.e1BfPH23Z-jVREoTv9v6-wHaE7?rs=1&pid=ImgDetMain" ,
  //       smallDescription :"Ensures surfaces are perfectly horizontal or vertical" ,
  //       rentPriceParHour :4.00
  //     ),
  // Tool(
  //       id:10,
  //       category: 1 ,
  //       title:"Utility Knife"  ,
  //       imageUrl:"https://th.bing.com/th/id/OIP.N9smFCCaUUCrV0BI0-6wfwHaE6?rs=1&pid=ImgDetMain" ,
  //       smallDescription :"Versatile cutting tool for a variety of materials" ,
  //       rentPriceParHour :3.00
  //     ),
  // Tool(
  //       id:11,
  //       category: 2 ,
  //       title:"Concrete Mixer"  ,
  //       imageUrl:"https://image.made-in-china.com/2f0j00ljRantTGHJqy/Zhishan-CM220-240-260-CM50-CM800-Electric-Portable-Cement-Concrete-Mixer.jpg" ,
  //       smallDescription :"Mixes concrete for pouring foundations, slabs, and more" ,
  //       rentPriceParHour :50.00
  //     ),
  // Tool(
  //       id:12,
  //       category: 2 ,
  //       title:"Jackhammer"  ,
  //       imageUrl:"https://www.903inc.com/wp-content/uploads/2019/06/electric-jackhammer-rentals.jpg" ,
  //       smallDescription :"Powerful tool for destroying streets " ,
  //       rentPriceParHour :50.00
  //     ),

  // ];